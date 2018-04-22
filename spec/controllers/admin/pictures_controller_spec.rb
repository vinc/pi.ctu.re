require "rails_helper"

RSpec.describe Admin::PicturesController, type: :controller do
  context "without signed in admin" do
    describe "GET #index" do
      it "returns http success" do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  context "with signed in admin" do
    let(:admin) { FactoryBot.create(:user, role: "admin") }

    before(:each) do
      sign_in admin
    end

    describe "GET #index" do
      it "returns http success" do
        get :index
        expect(response).to be_successful
      end
    end
  end
end
