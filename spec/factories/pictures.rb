require 'faker'

FactoryGirl.define do
  factory :picture do
    caption { Faker::Lorem.sentence }
    image   { File.open(Rails.root.join('app/assets/images/home_bg.jpg')) }
    user
  end
end
