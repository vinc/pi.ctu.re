# == Schema Information
#
# Table name: invitations
#
#  id          :integer          not null, primary key
#  token       :string
#  email       :string
#  approved_at :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Invitation < ApplicationRecord
  include Tokenizable

  def approve
    update(approved_at: Time.zone.now)
  end

  def self.approved
    where.not(approved_at: nil)
  end
end
