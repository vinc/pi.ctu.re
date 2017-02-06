require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has a valid factory' do
    user = FactoryGirl.build(:user)
    expect(user).to be_valid
  end

  describe 'validations' do
    subject { FactoryGirl.build(:user) }

    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_presence_of(:email) }

    it { is_expected.to validate_uniqueness_of(:username).case_insensitive }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  end

  describe 'associations' do
    it { is_expected.to have_many(:pictures) }
  end

  describe '.name' do
    it 'returns fullname when defined' do
      user = FactoryGirl.build(:user)
      expect(user.name).to eql(user.fullname)
    end

    it 'returns username when fullname is not defined' do
      user = FactoryGirl.build(:user, fullname: nil)
      expect(user.name).to eql(user.username)
    end
  end
end
