require 'rails_helper'

RSpec.feature 'UserSignUp', type: :feature do
  before :each do
    @user = FactoryGirl.build(:user)
  end

  scenario 'User signs up' do
    visit '/account/sign_up'

    fill_in 'Email',                 with: @user.email
    fill_in 'Username',              with: @user.username
    fill_in 'Password',              with: @user.password
    fill_in 'Password confirmation', with: @user.password
    click_button 'Sign up'

    expect(page).to have_text('signed up successfully')
  end
end
