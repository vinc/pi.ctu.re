class Picture < ApplicationRecord
  mount_uploader :image, ImageUploader

  before_create do
    self.token = self.class.generate_unique_secure_token(:token)
  end

  def to_param
    self.token
  end

  def regenerate_token!
    self.update(token: self.class.generate_unique_secure_token(:token))
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
