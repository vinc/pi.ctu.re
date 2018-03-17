require "rails_helper"

RSpec.describe PicturePolicy do
  let(:user) { FactoryBot.build(:user) }

  subject { described_class }

  context "with picture" do
    let(:picture) { FactoryBot.create(:picture) }

    permissions :show? do
      it "grants access" do
        expect(subject).to permit(user, picture)
      end
    end

    permissions :index?, :new?, :create?, :edit?, :update?, :destroy? do
      it "denies access" do
        expect(subject).not_to permit(user, picture)
      end
    end
  end
end
