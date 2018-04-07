require "rails_helper"

RSpec.describe ExploreController, type: :controller do
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
end
