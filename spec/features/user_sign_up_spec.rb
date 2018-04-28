require "rails_helper"

RSpec.feature "UserSignUp", type: :feature do
  context "with invitation enabled" do
    before do
      Rails.configuration.invitation_enabled = true
    end

    let(:user) { FactoryBot.build(:user, invitation_token: nil) }

    scenario "User signs up" do
      visit "/account/signup"

      click_link "Request an invitation code"
      fill_in "Email", with: user.email
      click_button "Request invitation"

      invitation = Invitation.find_by(email: user.email)
      invitation.update(approved_at: Time.now)

      visit "/account/signup"

      fill_in "Invitation code",       with: invitation.token
      fill_in "Email",                 with: user.email
      fill_in "Username",              with: user.username
      fill_in "Password",              with: user.password
      fill_in "Password confirmation", with: user.password
      click_button "Sign up"

      expect(page).to have_text("signed up successfully")
    end
  end

  context "with invitation disabled" do
    before do
      Rails.configuration.invitation_enabled = false
    end

    let(:user) { FactoryBot.build(:user, invitation_token: nil) }

    scenario "User signs up" do
      visit "/account/signup"

      fill_in "Email",                 with: user.email
      fill_in "Username",              with: user.username
      fill_in "Password",              with: user.password
      fill_in "Password confirmation", with: user.password
      click_button "Sign up"

      expect(page).to have_text("signed up successfully")
    end
  end
end
