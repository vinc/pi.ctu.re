class Picture < ApplicationRecord
  include OrderQuery

  belongs_to :user

  mount_uploader :image, ImageUploader

  acts_as_votable

  before_create do
    self.token = self.class.generate_unique_secure_token(:token)
  end

  def to_param
    self.token
  end

  def regenerate_token
    self.update(token: self.class.generate_unique_secure_token(:token))
  end

  def self.order_by(type)
    case type || :view
    when :view
      order_by_view
    when :time
      order_by_time
    else
      raise ArgumentError
    end
  end

  order_query :order_by_view, [:views_count, :desc]
  order_query :order_by_time, [:created_at, :desc]

  private

  def self.generate_unique_secure_token(attribute)
    10.times do |i|
      token = SecureRandom::base58(8).downcase
      return token unless exists?(attribute => token)
    end
    raise "Couldn't generate a unique token in 10 attempts!"
  end
end
