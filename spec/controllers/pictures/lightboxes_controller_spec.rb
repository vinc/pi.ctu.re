require "rails_helper"

RSpec.describe Pictures::LightboxesController, type: :controller do
  describe "GET #show" do
    let(:picture) { FactoryBot.create(:picture) }

    it "returns http success" do
      get :show, params: { picture_token: picture.token }
      expect(response).to be_successful
    end
  end
end
