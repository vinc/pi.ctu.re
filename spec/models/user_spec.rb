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
#  followers_count        :integer          default(0)
#  followees_count        :integer          default(0)
#

require "rails_helper"

RSpec.describe User, type: :model do
  subject { FactoryBot.build(:user) }

  it "has a valid factory" do
    expect(subject).to be_valid
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_presence_of(:email) }

    it { is_expected.to validate_uniqueness_of(:username).case_insensitive }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  end

  describe "associations" do
    it { is_expected.to have_many(:pictures) }
    it { is_expected.to have_many(:followers) }
    it { is_expected.to have_many(:followees) }
  end

  describe "#name" do
    context "with fullname" do
      it "returns fullname" do
        expect(subject.name).to eql(subject.fullname)
      end
    end

    context "without fullname" do
      subject { FactoryBot.build(:user, fullname: nil) }

      it "returns username" do
        expect(subject.name).to eql(subject.username)
      end
    end
  end

  describe "#avatar" do
    describe "#path" do
      it "returns file path" do
        expect(subject.avatar.path).to match("/")
      end
    end
  end

  describe "#usage" do
    let!(:user_pictures) { FactoryBot.create_list(:picture, 5, user: subject) }

    it "returns the size of all pictures" do
      expect(subject.usage).to eq(user_pictures.map(&:image).map(&:size).sum)
    end
  end
end
