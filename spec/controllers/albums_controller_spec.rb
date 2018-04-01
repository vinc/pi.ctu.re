require "rails_helper"

RSpec.describe AlbumsController, type: :controller do
  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to be_successful
    end

    context "when nested in user" do
      let(:user) { FactoryBot.create(:user) }

      it "returns http success" do
        get :index, params: { user_username: user.username }
        expect(response).to be_successful
      end
    end
  end

  describe "GET #show" do
    context "when album exists" do
      let(:album) { FactoryBot.create(:album) }

      it "returns http success" do
        get :show, params: { token: album.token }
        expect(response).to be_successful
      end
    end

    context "when album does not exists" do
      it "throws ActiveRecord::RecordNotFound" do
        expect do
          get :show, params: { token: "invalid" }
        end.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end
  end

  context "with signed in user" do
    let(:user) { FactoryBot.create(:user) }

    before(:each) do
      sign_in user
    end

    describe "GET #new" do
      it "returns http success" do
        get :new
        expect(response).to be_successful
      end
    end

    describe "POST #create" do
      context "with valid album attributes" do
        let(:album_attributes) { FactoryBot.attributes_for(:album) }

        it "returns http redirect to #show" do
          post :create, params: { album: album_attributes }
          expect(response).to redirect_to(Album.last)
        end
      end

      context "with invalid album attributes" do
        let(:album_attributes) { FactoryBot.attributes_for(:album, title: "") }

        it "returns http success" do
          post :create, params: { album: album_attributes }
          expect(response).to be_successful
        end
      end
    end

    context "with an album" do
      let(:album) { FactoryBot.create(:album) }

      describe "GET #edit" do
        it "returns http success" do
          get :edit, params: { token: album.token }
          expect(response).to be_successful
        end
      end

      describe "PATCH #update" do
        it "returns http redirect to #show" do
          patch :update, params: { token: album.token, album: FactoryBot.attributes_for(:album) }
          expect(response).to redirect_to(album)
        end
      end

      describe "DELETE #destroy" do
        it "returns http redirect to #index" do
          delete :destroy, params: { token: album.token }
          expect(response).to redirect_to(albums_url)
        end
      end
    end
  end
end
