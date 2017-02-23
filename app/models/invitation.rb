class Invitation < ApplicationRecord
  include Tokenizable

  def approve
    self.update(approved_at: Time.zone.now)
  end

  def self.approved
    where.not(approved_at: nil)
  end
end
