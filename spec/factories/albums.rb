require 'faker'

FactoryBot.define do
  factory :album do
    title { Faker::Lorem.word }
    user
  end
end
