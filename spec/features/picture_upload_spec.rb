require "rails_helper"

RSpec.feature "PictureUpload", type: :feature do
  include Warden::Test::Helpers

  before :each do
    @user = FactoryBot.create(:user)
    login_as(@user, scope: :user)
  end

  scenario "User upload a picture" do
    visit "/p/new"

    attach_file("Image", Rails.root.join("app/assets/images/home_bg.jpg"))
    fill_in "Caption", with: Faker::Lorem.sentence
    click_button "Upload"

    expect(page).to have_text("0 likes")
  end
end
