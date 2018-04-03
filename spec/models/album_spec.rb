# == Schema Information
#
#

require "rails_helper"

RSpec.describe Album, type: :model do
  subject { FactoryBot.build(:album) }

  it "has a valid factory" do
    expect(subject).to be_valid
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:title).is_at_most(Album::TITLE_LENGTH_MAX) }
  end

  describe "associations" do
    it { is_expected.to belong_to(:user) }
  end
end
