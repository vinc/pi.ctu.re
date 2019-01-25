require "rails_helper"

RSpec.describe TimelineChannel, type: :channel do
  context "when not authenticated" do
    before do
      stub_connection current_user: nil
    end

    it "rejects subscription" do
      subscribe
      expect(subscription).to be_rejected
    end
  end

  context "when authenticated" do
    let(:user) { FactoryBot.create(:user) }

    before do
      stub_connection current_user: user
    end

    it "subscribes to a stream" do
      subscribe

      expect(subscription).to be_confirmed
      expect(subscription).to have_stream_from(/timeline/)
    end
  end
end
