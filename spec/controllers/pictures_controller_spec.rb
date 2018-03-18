require "rails_helper"

RSpec.describe PicturesController, type: :controller do
  describe "GET #index" do
    context "with default order" do
      it "returns http success" do
        get :index
        expect(response).to be_successful
      end
    end

    context "with time order" do
      it "returns http success" do
        get :index, params: { order: "time" }
        expect(response).to be_successful
      end
    end

    context "with view order" do
      it "returns http success" do
        get :index, params: { order: "view" }
        expect(response).to be_successful
      end
    end

    context "with invalid order" do
      it "raises ActionController::BadRequest" do
        expect do
          get :index, params: { order: "invalid" }
        end.to raise_exception(ActionController::BadRequest)
      end
    end
  end

  describe "GET #show" do
    context "when picture exists" do
      let(:picture) { FactoryBot.create(:picture) }

      context "with default order" do
        it "returns http success" do
          get :show, params: { token: picture.token }
          expect(response).to be_successful
        end
      end

      context "with view order" do
        it "returns http success" do
          get :show, params: { token: picture.token, order: "view" }
          expect(response).to be_successful
        end
      end
    end

    context "when picture does not exists" do
      it "raises ActiveRecord::RecordNotFound" do
        expect do
          get :show, params: { token: "invalid" }
        end.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe "GET #search" do
    it "returns http success" do
      get :search, params: { q: Faker::Lorem.word }
      expect(response).to be_successful
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
      context "with valid picture attributes" do
        let(:picture_attributes) { FactoryBot.attributes_for(:picture, :with_uploaded_file) }

        it "returns http redirect to #show" do
          post :create, params: { picture: picture_attributes }
          expect(response).to redirect_to(Picture.last)
        end
      end

      context "with invalid picture attributes" do
        let(:picture_attributes) { FactoryBot.attributes_for(:picture).except(:image) }

        it "returns http success" do
          post :create, params: { picture: picture_attributes }
          expect(response).to be_successful
        end
      end
    end

    context "with a picture" do
      let(:picture) { FactoryBot.create(:picture) }

      describe "GET #edit" do
        it "returns http success" do
          get :edit, params: { token: picture.token }
          expect(response).to be_successful
        end
      end

      describe "PATCH #update" do
        let(:picture_attributes) { FactoryBot.attributes_for(:picture).except(:image) }

        it "returns http redirect to #show" do
          patch :update, params: { token: picture.token, picture: picture_attributes }
          expect(response).to redirect_to(picture)
        end
      end

      describe "DELETE #destroy" do
        it "returns http redirect to #index" do
          delete :destroy, params: { token: picture.token }
          expect(response).to redirect_to(pictures_url)
        end
      end

      describe "PUT #like" do
        it "returns http redirect to #show" do
          put :like, params: { token: picture.token }
          expect(response).to redirect_to(picture)
        end
      end

      describe "PUT #unlike" do
        it "returns http redirect to #show" do
          put :unlike, params: { token: picture.token }
          expect(response).to redirect_to(picture)
        end
      end
    end
  end

  context "with signed in admin" do
    let(:admin) { FactoryBot.create(:user, is_admin: true) }

    before(:each) do
      sign_in admin
    end

    context "with a picture" do
      let(:picture) { FactoryBot.create(:picture) }

      describe "PUT #feature" do
        it "returns http redirect to #show" do
          put :feature, params: { token: picture.token }
          expect(response).to redirect_to(picture)
        end
      end

      describe "PUT #unfeature" do
        it "returns http redirect to #show" do
          put :unfeature, params: { token: picture.token }
          expect(response).to redirect_to(picture)
        end
      end
    end
  end
end
