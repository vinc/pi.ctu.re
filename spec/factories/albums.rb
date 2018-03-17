# == Schema Information
#
# Table name: albums
#
#  id         :integer          not null, primary key
#  title      :string
#  token      :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require "faker"

FactoryBot.define do
  factory :album do
    title { Faker::Lorem.word }
    user
  end
end
