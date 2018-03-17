require "rails_helper"

RSpec.describe Account::BillingsController, type: :controller do
  context "with signed in user" do
    let(:user) { FactoryBot.create(:user) }

    before(:each) do
      sign_in user
    end

    describe "GET #show" do
      it "returns http success" do
        get :show
        expect(response).to be_successful
      end
    end
  end
end
