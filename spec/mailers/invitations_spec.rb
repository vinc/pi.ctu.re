require "rails_helper"
require "mail"

RSpec.describe InvitationsMailer, type: :mailer do
  describe "approve" do
    let(:invitation) { FactoryBot.create(:invitation) }
    let(:mail) { InvitationsMailer.approve(invitation) }
    let(:sender) { Mail::Address.new(ENV["MAILER_SENDER"]).address }

    it "renders the headers" do
      expect(mail.subject).to eq("Invitation to Picture approved")
      expect(mail.to).to eq([invitation.email])
      expect(mail.from).to eq([sender])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hello #{invitation.email}")
    end
  end
end
