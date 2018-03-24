require "rails_helper"

RSpec.feature "Home", type: :feature do
  scenario "User visits the homepage" do
    visit "/"

    body_html = I18n.t("welcome.body_html")
    body_text = ActionView::Base.full_sanitizer.sanitize(body_html)
    expect(page).to have_text(body_text)
  end
end
