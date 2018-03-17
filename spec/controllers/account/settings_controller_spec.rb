require "rails_helper"

RSpec.describe Account::SettingsController, type: :controller do
  context "with signed in user" do
    let(:user) { FactoryBot.create(:user) }

    before(:each) do
      sign_in user
    end

    describe "GET #edit" do
      it "returns http success" do
        get :edit
        expect(response).to be_successful
      end
    end

    describe "PATCH #update" do
      context "with valid user attributes" do
        let(:user_attributes) { { default_license: "CC BY" } }

        it "returns http redirect to #edit" do
          patch :update, params: { user: user_attributes }
          expect(response).to redirect_to(edit_account_settings_path)
        end
      end

      context "with invalid album attributes" do
        let(:user_attributes) { { default_license: "WTF" } }

        it "returns http success" do
          patch :update, params: { user: user_attributes }
          expect(response).to be_successful
        end
      end
    end
  end
end
