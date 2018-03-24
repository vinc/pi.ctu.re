require "rails_helper"

RSpec.describe AboutController, type: :controller do
  describe "GET #contact" do
    it "returns http success" do
      get :contact
      expect(response).to be_successful
    end
  end

  describe "GET #pricing" do
    it "returns http success" do
      get :pricing
      expect(response).to be_successful
    end
  end
end
