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

  def alt
    self.caption.presence || self.token
  end

  def user_balance_cannot_be_negative
    unless self.user.balance > 0
      errors.add(:user_id, 'data balance cannot be negative')
    end
  end

  def size(version = nil)
    (version ? self.image.versions[version] : self.image).size
  end

  def charge_user(version = nil)
    self.user.decrement!(:balance, self.size(version))
  end

  def regenerate_token
    old_path = Rails.root.join('public', self.image.store_dir)
    self.update(token: self.class.generate_unique_secure_token(:token))
    new_path = Rails.root.join('public', self.image.store_dir)
    FileUtils.mv(old_path, new_path)
  end

  def exif
    @exif ||= EXIFR::JPEG.new(self.image.path) # TODO: Save in database
  end

  def image_tag_size(version = nil)
    return if self.width.nil? || self.height.nil?

    case version
    when :thumb
      h = 500
      w = self.width * h / self.height
      "#{w}x#{h}"
    else
      "#{self.width}x#{self.height}"
    end
  end

  def self.featured
    self.where(is_featured: true)
  end
end
