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

  describe "GET #followers" do
    let(:user) { FactoryBot.create(:user) }

    it "returns http success" do
      get :followers, params: { username: user.username }
      expect(response).to be_successful
    end
  end

  describe "GET #followees" do
    let(:user) { FactoryBot.create(:user) }

    it "returns http success" do
      get :followees, params: { username: user.username }
      expect(response).to be_successful
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

    context "with a user to follow" do
      let(:user_to_follow) { FactoryBot.create(:user) }

      describe "PATCH #follow" do
        it "returns http redirect to #show" do
          expect(user_to_follow.followers).not_to include(user)

          patch :follow, params: { username: user_to_follow.username }
          expect(response).to redirect_to(user_to_follow)

          expect(user_to_follow.reload.followers).to include(user)
        end
      end
    end

    context "with a user to unfollow" do
      let(:user_to_unfollow) { FactoryBot.create(:user) }

      describe "PATCH #unfollow" do
        before do
          user_to_unfollow.followers << user
        end

        it "returns http redirect to #show" do
          expect(user_to_unfollow.reload.followers).to include(user)

          patch :unfollow, params: { username: user_to_unfollow.username }
          expect(response).to redirect_to(user_to_unfollow)

          expect(user_to_unfollow.followers).not_to include(user)
        end
      end
    end
  end
end
