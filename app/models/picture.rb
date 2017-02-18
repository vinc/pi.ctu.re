class Picture < ApplicationRecord
  include OrderQuery
  include Tokenizable

  belongs_to :user
  has_and_belongs_to_many :albums

  mount_uploader :image, ImageUploader

  acts_as_votable

  order_query :order_by_view, [:views_count, :desc]
  order_query :order_by_time, [:created_at, :desc]

  validates_presence_of :image
  validate :user_balance_cannot_be_negative, on: :create

  def user_balance_cannot_be_negative
    unless self.user.balance > 0
      errors.add(:user_id, 'data balance cannot be negative')
    end
  end

  def alt
    self.caption.presence || self.token
  end

  def exif
    # TODO: Save in database
    @exif ||= EXIFR::JPEG.new(StringIO.new(self.image.file.read))
  end

  def self.featured
    self.where(is_featured: true)
  end
end
