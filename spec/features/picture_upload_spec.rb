require 'rails_helper'

include Warden::Test::Helpers

RSpec.feature 'PictureUpload', type: :feature do
  before :each do
    @user = FactoryGirl.create(:user)
    login_as(@user, :scope => :user)
  end

  scenario 'User upload a picture' do
    visit '/p/new'

    attach_file('Image', Rails.root.join('app/assets/images/home_bg.jpg'))
    fill_in 'Caption',  with: Faker::Lorem.sentence
    click_button 'Create Picture'

    expect(page).to have_text('0 likes')
  end
end
