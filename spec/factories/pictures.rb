require 'faker'

FactoryGirl.define do
  factory :picture do
    caption { Faker::Lorem.sentence }
  end
end
