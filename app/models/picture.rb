# == Schema Information
#
# Table name: pictures
#
#  id             :integer          not null, primary key
#  caption        :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :integer
#  token          :string
#  views_count    :integer          default(0), not null
#  image_height   :integer
#  image_width    :integer
#  is_featured    :boolean          default(FALSE), not null
#  image          :integer          not null
#  image_filename :string
#

require "exifr/jpeg"

class Picture < ApplicationRecord
  include OrderQuery
  include Tokenizable

  CAPTION_LENGTH_MAX = 500

  belongs_to :user
  has_and_belongs_to_many :albums

  mount_uploader :image, ImageUploader

  acts_as_votable

  order_query :order_by_view, %i[views_count desc]
  order_query :order_by_time, %i[created_at desc]

  validates_presence_of :image
  validate :user_balance_cannot_be_negative, on: :create
  validates :caption, length: { maximum: CAPTION_LENGTH_MAX }

  def user_balance_cannot_be_negative
    errors.add(:user_id, "data balance cannot be negative") if user.billable? && user.balance.negative?
  end

  def alt
    caption.presence || "Picture #{token}"
  end

  def exif
    # TODO: Save in database
    @exif ||= EXIFR::JPEG.new(StringIO.new(image.file.read))
  end

  def self.featured
    where(is_featured: true)
  end
end
