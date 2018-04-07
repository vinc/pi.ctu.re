require "rails_helper"

RSpec.describe Pictures::LikesController, type: :controller do
  context "with signed in user" do
    let(:user) { FactoryBot.create(:user) }

    before(:each) do
      sign_in user
    end

    context "with a picture" do
      let(:picture) { FactoryBot.create(:picture) }

      describe "POST #create" do
        it "returns http redirect to pictures#show" do
          post :create, params: { picture_token: picture.token }
          expect(response).to redirect_to(picture)
        end
      end

      describe "DELETE #destroy" do
        it "returns http redirect to pictures#show" do
          delete :destroy, params: { picture_token: picture.token }
          expect(response).to redirect_to(picture)
        end
      end
    end
  end
end
