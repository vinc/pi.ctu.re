require 'rails_helper'

RSpec.describe Invitation, type: :model do
  it 'has a valid factory' do
    invitation = FactoryGirl.build(:invitation)
    expect(invitation).to be_valid
  end

  describe '.approve' do
    it 'approves invitation' do
      invitation = FactoryGirl.create(:invitation)
      expect(invitation.approved_at).to be_nil
      invitation.approve
      expect(invitation.approved_at).not_to be_nil
    end
  end
  
  describe 'approved' do
    it 'filters approved invitations' do
      5.times { FactoryGirl.create(:invitation) }
      expect(Invitation.approved.count).to eq(0)

      Invitation.first.approve
      expect(Invitation.approved.count).to eq(1)
    end
  end
end
