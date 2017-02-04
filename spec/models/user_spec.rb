require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has a valid factory' do
    user = FactoryGirl.build(:user)
    expect(user).to be_valid
  end

  it 'is invalid without a username' do
    user = FactoryGirl.build(:user, username: nil)
    expect(user).not_to be_valid
  end

  it 'is invalid without an email' do
    user = FactoryGirl.build(:user, email: nil)
    expect(user).not_to be_valid
  end
end
