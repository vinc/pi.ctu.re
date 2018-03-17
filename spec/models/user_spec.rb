# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  username               :string
#  balance                :integer          default(0), not null
#  fullname               :string
#  default_license        :string           default("CC BY-NC-ND"), not null
#  is_admin               :boolean          default(FALSE), not null
#  avatar                 :integer
#  avatar_filename        :string
#  customer_id            :string
#

require "rails_helper"

RSpec.describe User, type: :model do
  it "has a valid factory" do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end

  describe "validations" do
    subject { FactoryBot.build(:user) }

    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_presence_of(:email) }

    it { is_expected.to validate_uniqueness_of(:username).case_insensitive }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  end

  describe "associations" do
    it { is_expected.to have_many(:pictures) }
  end

  describe ".name" do
    it "returns fullname when defined" do
      user = FactoryBot.build(:user)
      expect(user.name).to eql(user.fullname)
    end

    it "returns username when fullname is not defined" do
      user = FactoryBot.build(:user, fullname: nil)
      expect(user.name).to eql(user.username)
    end
  end
end
