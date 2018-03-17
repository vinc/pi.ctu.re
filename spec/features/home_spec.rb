require "rails_helper"

RSpec.feature "Home", type: :feature do
  scenario "User visits the homepage" do
    visit "/"

    expect(page).to have_text("Welcome to Picture")
  end
end
