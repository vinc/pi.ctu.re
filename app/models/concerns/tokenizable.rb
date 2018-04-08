module Tokenizable
  extend ActiveSupport::Concern

  included do
    before_create :set_token
  end

  def set_token
    self.token = self.class.generate_unique_secure_token(:token)
  end

  def to_param
    token
  end

  def regenerate_token
    update(token: self.class.generate_unique_secure_token(:token))
  end

  module ClassMethods
    def generate_unique_secure_token(attribute)
      (8..32).each do |length|
        10.times do
          token = SecureRandom.uuid.tr("-", "").slice(0, length)
          return token unless exists?(attribute => token)
        end
      end
    end
  end
end
