require "rails_helper"
require "stripe_mock"

RSpec.describe Account::ChargesController, type: :controller do
  let(:stripe_helper) { StripeMock.create_test_helper }
  before { StripeMock.start }
  after { StripeMock.stop }

  context "with signed in user" do
    let(:user) { FactoryBot.create(:user) }

    before(:each) do
      sign_in user
    end

    describe "GET #create" do
      let(:amount) { "5000" } # 5.00 EUR
      let(:card_token) { stripe_helper.generate_card_token }

      context "with valid card" do
        it "returns http redirect to account billing" do
          expect(user.customer_id).to be_nil
          old_user_balance = user.balance

          get :create, params: { amount: amount, token_id: card_token }
          expect(response).to redirect_to(account_billing_path)
          expect(user.reload.balance).to be > old_user_balance

          expect(user.customer_id).not_to be_nil
          old_user_balance = user.balance

          get :create, params: { amount: amount, token_id: card_token }
          expect(response).to redirect_to(account_billing_path)
          expect(user.reload.balance).to be > old_user_balance
        end
      end

      context "with invalid card" do
        before { StripeMock.prepare_card_error(:card_declined) }

        it "returns http redirect to account billing" do
          old_user_balance = user.balance

          get :create, params: { amount: amount, token_id: card_token }
          expect(response).to redirect_to(account_billing_path)
          expect(user.reload.balance).to eq(old_user_balance)
        end
      end
    end
  end
end
