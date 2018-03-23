require "rails_helper"

RSpec.describe ApplicationHelper, type: :helper do
  describe "#body_class" do
    context "within welcome#index" do
      it "returns a string" do
        allow(helper).to receive(:controller_path) { "welcome" }
        allow(helper).to receive(:action_name) { "index" }

        expect(helper.body_class).to eq("welcome-index")
      end
    end

    context "within account/settings#edit" do
      it "returns a string" do
        allow(helper).to receive(:controller_path) { "account/settings" }
        allow(helper).to receive(:action_name) { "edit" }

        expect(helper.body_class).to eq("account-settings-edit")
      end
    end
  end
end
