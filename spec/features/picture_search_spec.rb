require "rails_helper"

RSpec.feature "PictureSearch", type: :feature do
  before :each do
    2.times { FactoryBot.create(:picture) }
    FactoryBot.create(:picture, description: "foo")
    FactoryBot.create(:picture, description: "foo bar")
    FactoryBot.create(:picture, description: "bar foo")
    FactoryBot.create(:picture, description: "FOO")
  end

  scenario "Search picture" do
    Capybara.enable_aria_label = true

    visit "/explore"

    fill_in "Query", with: "foo"
    click_button "Search"

    expect(page).to have_text("4 pictures found")
  end
end
