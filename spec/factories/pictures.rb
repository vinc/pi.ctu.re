require 'faker'

FactoryGirl.define do
  factory :picture do
    caption { Faker::Lorem.sentence }
    user
  end
end
