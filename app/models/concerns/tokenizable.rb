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
      10.times do |_i|
        token = SecureRandom.uuid.slice(0, 8)
        return token unless exists?(attribute => token)
      end
      raise "Couldn't generate a unique token in 10 attempts!"
    end
  end
end
