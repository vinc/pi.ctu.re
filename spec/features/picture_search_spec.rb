require 'rails_helper'

RSpec.feature 'PictureSearch', type: :feature do
  before :each do
    2.times { FactoryBot.create(:picture) }
    FactoryBot.create(:picture, caption: 'foo')
    FactoryBot.create(:picture, caption: 'foo bar')
    FactoryBot.create(:picture, caption: 'bar foo')
    FactoryBot.create(:picture, caption: 'FOO')
  end

  scenario 'Search picture' do
    Capybara.enable_aria_label = true

    visit '/explore'

    fill_in 'Query', with: 'foo'
    click_button 'Search'

    expect(page).to have_text('4 pictures found')
  end
end
