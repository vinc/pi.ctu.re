# == Schema Information
#
# Table name: albums
#
#  id         :integer          not null, primary key
#  title      :string
#  token      :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require "rails_helper"

RSpec.describe Album, type: :model do
  let(:stripe_helper) { StripeMock.create_test_helper }
  before { StripeMock.start }
  after { StripeMock.stop }

  before do
    customer = Stripe::Customer.create(
      email: Faker::Internet.email,
      source: stripe_helper.generate_card_token
    )
    5.times do
      Stripe::Charge.create(amount: 100, currency: "eur", customer: customer.id)
    end
  end

  it ".history" do
    charges = Charge.history
    expect(charges).not_to be_empty
    expect(charges.count).to eq(5)
  end

  context "with a user" do
    let(:user) { FactoryBot.create(:user) }

    context "without previous charges" do
      it ".history" do
        charges = Charge.history(user: user)
        expect(charges).to be_empty
      end
    end

    context "with previous charges" do
      before do
        customer = Stripe::Customer.create(
          email: user.email,
          source: stripe_helper.generate_card_token
        )
        user.update(customer_id: customer.id)
        Stripe::Charge.create(amount: 100, currency: "eur", customer: customer.id)
      end

      it ".history" do
        charges = Charge.history(user: user)
        expect(charges).not_to be_empty
        expect(charges.count).to eq(1)
        expect(charges.first.amount).to eq(100)
        expect(charges.first.currency).to eq("eur")
        expect(charges.first.user).to eq(user)
      end
    end
  end
end
