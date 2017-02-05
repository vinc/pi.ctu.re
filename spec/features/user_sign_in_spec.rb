require 'rails_helper'

RSpec.feature 'UserSignIn', type: :feature do
  before :each do
    @user = FactoryGirl.create(:user)
  end

  scenario 'User signs in' do
    visit '/u/sign_in'

    fill_in 'Username', with: @user.username
    fill_in 'Password', with: @user.password
    click_button 'Sign in'

    expect(page).to have_text('Signed in successfully')
  end
end
