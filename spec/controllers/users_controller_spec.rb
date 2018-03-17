require "rails_helper"

RSpec.describe UsersController, type: :controller do
  describe "GET #show" do
    context "when user exists" do
      let(:user) { FactoryBot.create(:user) }

      it "returns http success" do
        get :show, params: { username: user.username }
        expect(response).to be_successful
      end
    end

    context "when user does not exists" do
      it "throws ActiveRecord::RecordNotFound" do
        expect do
          get :show, params: { username: "invalid" }
        end.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end
  end

  context "with signed in user" do
    let(:user) { FactoryBot.create(:user) }

    before(:each) do
      sign_in user
    end

    describe "PATCH #update" do
      context "with valid user attributes" do
        let(:user_attributes) { FactoryBot.attributes_for(:user) }

        it "returns http redirect to #show" do
          patch :update, params: { username: user.username, user: user_attributes }
          expect(response).to redirect_to(user)
        end
      end
    end
  end
end
