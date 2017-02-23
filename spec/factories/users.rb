require 'faker'

FactoryGirl.define do
  factory :user do
    email                 { Faker::Internet.email }
    username              { Faker::Internet.user_name }
    fullname              { Faker::Name.name }
    password              'password'
    password_confirmation 'password'

    balance               100_000_000 # 100 MB

    invitation_token       Rails.application.secrets.invitation_token
  end
end
