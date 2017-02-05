class Picture < ApplicationRecord
  include OrderQuery

  belongs_to :user

  mount_uploader :image, ImageUploader

  acts_as_votable

  order_query :order_by_view, [:views_count, :desc]
  order_query :order_by_time, [:created_at, :desc]

  before_create do
    self.token = self.class.generate_unique_secure_token(:token)
  end

  def to_param
    self.token
  end

  def regenerate_token
    self.update(token: self.class.generate_unique_secure_token(:token))
  end

  def size(version = nil)
    (version ? self.image.versions[version] : self.image).size
  end

  def charge_user(version = nil)
    self.user.decrement!(:balance, self.size(version))
  end

  private

  def self.generate_unique_secure_token(attribute)
    10.times do |i|
      token = SecureRandom::base58(8).downcase
      return token unless exists?(attribute => token)
    end
    raise "Couldn't generate a unique token in 10 attempts!"
  end
end
