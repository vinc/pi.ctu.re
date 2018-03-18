require "rails_helper"

RSpec.describe Admin::InvitationsController, type: :controller do
  context "without signed in admin" do
    describe "GET #index" do
      it "returns http success" do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  context "with signed in admin" do
    let(:admin) { FactoryBot.create(:user, is_admin: true) }

    before(:each) do
      sign_in admin
    end

    describe "GET #index" do
      it "returns http success" do
        get :index
        expect(response).to be_successful
      end
    end

    context "with an invitation" do
      let(:invitation) { FactoryBot.create(:invitation) }

      describe "PUT #approve" do
        it "returns http redirect to #index" do
          put :approve, params: { token: invitation.token }
          expect(response).to redirect_to(admin_invitations_path)
          expect(invitation.reload.approved_at).not_to be_nil
        end
      end
    end
  end
end
