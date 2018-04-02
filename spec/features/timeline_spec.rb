require "rails_helper"

RSpec.feature "Timeline", type: :feature do
  include Warden::Test::Helpers

  context "without authenticated user" do
    scenario "Guest visits the homepage", js: true do
      visit "/"

      expect(page).not_to have_text("Latest pictures from your timeline")
    end
  end

  context "with authenticated user" do
    let!(:user) { FactoryBot.create(:user) }

    before :each do
      following_user = FactoryBot.create(:user)
      following_user.followers << user
      FactoryBot.create_list(:picture, 5, user: following_user)

      login_as(user, scope: :user)
    end

    scenario "Member visits the homepage", js: true do
      visit "/"

      expect(page).to have_text("Latest pictures from your timeline")

      FactoryBot.create(:picture, user: user.followees.last)

      expect(page).to have_text("Refresh to see")
      page.save_screenshot
    end
  end
end
