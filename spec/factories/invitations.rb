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

FactoryBot.define do
  factory :invitation do
    email       { Faker::Internet.email }
    approved_at { nil }
  end
end
