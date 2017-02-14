require 'rails_helper'

RSpec.feature 'PictureSearch', type: :feature do
  before :each do
    2.times { FactoryGirl.create(:picture) }
    FactoryGirl.create(:picture, caption: 'foo')
    FactoryGirl.create(:picture, caption: 'foo bar')
    FactoryGirl.create(:picture, caption: 'bar foo')
    FactoryGirl.create(:picture, caption: 'FOO')
  end

  scenario 'Search picture' do
    Capybara.enable_aria_label = true

    visit '/explore'

    fill_in 'Query', with: 'foo'
    click_button 'Search'

    expect(page).to have_text('4 pictures found')
  end
end
