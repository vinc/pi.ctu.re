require 'rails_helper'

RSpec.feature 'UserSignIn', type: :feature do
  before :each do
    @user = FactoryBot.create(:user)
  end

  scenario 'User signs in' do
    visit '/account/sign_in'

    fill_in 'Email',    with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Sign in'

    expect(page).to have_text('Signed in successfully')
  end
end
