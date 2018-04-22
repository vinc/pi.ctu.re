require "rails_helper"

RSpec.feature "PictureDisabled", type: :feature do
  include Warden::Test::Helpers

  subject { FactoryBot.create(:picture, status: "disabled") }

  context "with nobody signed in" do
    scenario "cannot view picture" do
      expect { visit picture_path(subject) }.to raise_exception(Pundit::NotAuthorizedError)
    end
  end

  context "with author signed in" do
    before { login_as(subject.user, scope: :user) }

    scenario "can view picture" do
      visit picture_path(subject)

      expect(page).to have_text(I18n.translate("pictures.show.disabled"))
    end
  end

  context "with admin signed in" do
    before { login_as(FactoryBot.create(:user, role: "admin"), scope: :user) }

    scenario "can view picture" do
      visit picture_path(subject)

      expect(page).to have_text(I18n.translate("pictures.show.disabled"))
    end
  end
end
