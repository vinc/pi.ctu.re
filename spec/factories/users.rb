# == Schema Information
#
# Table name: users
#
#  id                      :integer          not null, primary key
#  email                   :string           default(""), not null
#  encrypted_password      :string           default(""), not null
#  reset_password_token    :string
#  reset_password_sent_at  :datetime
#  remember_created_at     :datetime
#  sign_in_count           :integer          default(0), not null
#  current_sign_in_at      :datetime
#  last_sign_in_at         :datetime
#  current_sign_in_ip      :inet
#  last_sign_in_ip         :inet
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  username                :string
#  balance                 :integer          default(0), not null
#  fullname                :string
#  default_license         :string           default("CC BY-NC-ND"), not null
#  avatar                  :integer
#  avatar_filename         :string
#  customer_id             :string
#  followers_count         :integer          default(0)
#  followees_count         :integer          default(0)
#  default_privacy_setting :integer
#  role                    :integer          default("member")
#  locale                  :string
#

require "faker"

FactoryBot.define do
  factory :user do
    email                 { Faker::Internet.email }
    username              { Faker::Internet.user_name(nil, "-") + rand(10_000..99_999).to_s }
    fullname              { Faker::Name.name }
    password              { Faker::Internet.password }
    password_confirmation(&:password)

    balance               100_000_000 # 100 MB

    invitation_token      { FactoryBot.create(:invitation, email: email, approved_at: Time.zone.now).token }
  end
end
