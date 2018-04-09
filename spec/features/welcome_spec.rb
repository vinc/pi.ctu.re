require "rails_helper"

RSpec.feature "Welcome", type: :feature do
  scenario "Guest visits the homepage" do
    visit "/"

    body_html = I18n.t("welcome.index.sections.what.title")
    body_text = ActionView::Base.full_sanitizer.sanitize(body_html)
    expect(page).to have_text(body_text)
  end
end
