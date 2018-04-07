require "rails_helper"

RSpec.describe PicturePolicy do
  let(:user) { FactoryBot.build(:user) }

  subject { described_class }

  context "with public picture" do
    let(:picture) { FactoryBot.create(:picture, privacy_setting: "public") }

    permissions :index?, :show? do
      it "grants access" do
        expect(subject).to permit(user, picture)
      end
    end

    permissions :new?, :create?, :edit?, :update?, :destroy? do
      it "denies access" do
        expect(subject).not_to permit(user, picture)
      end
    end
  end

  context "with private picture" do
    let(:picture) { FactoryBot.create(:picture, privacy_setting: "private") }

    permissions :show?, :new?, :create?, :edit?, :update?, :destroy? do
      it "denies access" do
        expect(subject).not_to permit(user, picture)
      end
    end
  end
end
