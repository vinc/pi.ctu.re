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
  include OrderQuery
  include Tokenizable

  order_query :order_by_time, %i[created_at desc]

  def self.approved
    where.not(approved_at: nil)
  end
end
