require "rails_helper"

RSpec.feature "UserSignUp", type: :feature do
  before :each do
    @user = FactoryBot.build(:user, invitation_token: nil)
  end

  scenario "User signs up" do
    visit "/account/sign_up"

    click_link "Request an invitation token"
    fill_in "Email", with: @user.email
    click_button "Request invitation"

    @invitation = Invitation.find_by(email: @user.email)
    @invitation.update(approved_at: Time.now)

    visit "/account/sign_up"

    fill_in "Invitation token",      with: @invitation.token
    fill_in "Email",                 with: @user.email
    fill_in "Username",              with: @user.username
    fill_in "Password",              with: @user.password
    fill_in "Password confirmation", with: @user.password
    click_button "Sign up"

    expect(page).to have_text("signed up successfully")
  end
end
