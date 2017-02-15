require 'faker'

FactoryGirl.define do
  factory :album do
    title { Faker::Lorem.word }
    user
  end
end
