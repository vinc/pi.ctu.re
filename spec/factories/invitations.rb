FactoryGirl.define do
  factory :invitation do
    email       { Faker::Internet.email }
    approved_at { nil }
  end
end
