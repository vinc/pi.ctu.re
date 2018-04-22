# == Schema Information
#
# Table name: pictures
#
#  id                 :integer          not null, primary key
#  caption            :text
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  user_id            :integer
#  token              :string
#  views_count        :integer          default(0), not null
#  image_height       :integer
#  image_width        :integer
#  is_featured        :boolean          default(FALSE), not null
#  image              :integer          not null
#  image_filename     :string
#  privacy_setting    :integer          default("public")
#  cached_votes_total :integer          default(0)
#  status             :integer          default("enabled")
#

require "exifr/jpeg"

class Picture < ApplicationRecord
  include OrderQuery
  include Tokenizable

  CAPTION_LENGTH_MAX = 500

  attr_accessor :protected_param
  attr_accessor :regenerate_secret

  belongs_to :user
  has_and_belongs_to_many :albums, after_add: :touch_album, after_remove: :touch_album

  mount_uploader :image, ImageUploader

  acts_as_votable

  order_query :order_by_view, %i[views_count desc]
  order_query :order_by_time, %i[created_at desc]

  enum privacy_setting: %i[public protected private], _suffix: :setting
  enum status: %i[enabled disabled]

  validates_presence_of :image
  validates :caption, length: { maximum: CAPTION_LENGTH_MAX }
  validate :user_balance_cannot_be_negative, on: :create

  after_create_commit :notify!
  before_update :regenerate_protected_secret!, if: :regenerate_secret

  def initialize(params = {})
    super
    write_attribute(:privacy_setting, params[:privacy_setting] || user.default_privacy_setting) if user.present?
  end

  def notify!
    PictureNotificationJob.perform_later(self)
  end

  def alt
    caption.presence || "Picture #{token}"
  end

  def exif
    # TODO: Save in database
    @exif ||= EXIFR::JPEG.new(StringIO.new(image.file.read))
  end

  def protected_secret
    Digest::SHA1.hexdigest(image.filename) if protected_setting?
  end

  def regenerate_protected_secret!
    Digest::SHA1.hexdigest(image.generate_filename) if protected_setting?
  end

  def self.featured
    where(is_featured: true)
  end

  private

  def touch_album(album)
    album.touch if persisted?
  end

  def user_balance_cannot_be_negative
    errors.add(:user_id, "data balance cannot be negative") if user.billable? && user.balance.negative?
  end
end
