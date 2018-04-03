# == Schema Information
#
# Table name: invitations
#
#  id          :integer          not null, primary key
#  token       :string
#  email       :string
#  approved_at :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require "rails_helper"

RSpec.describe Invitation, type: :model do
  subject { FactoryBot.build(:invitation) }

  it "has a valid factory" do
    expect(subject).to be_valid
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:email) }
  end

  describe ".approved" do
    let!(:invitations) { FactoryBot.create_list(:invitation, 5) }

    it "filters approved invitations" do
      expect(Invitation.approved.count).to eq(0)
      invitations.first.update(approved_at: Time.now)
      expect(Invitation.approved.count).to eq(1)
    end
  end
end
