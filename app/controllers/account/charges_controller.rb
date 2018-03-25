class Account::ChargesController < ApplicationController
  before_action :authenticate_user!
  before_action :create_customer

  def create
    charge = Stripe::Charge.create(
      customer:    current_user.customer_id,
      amount:      charge_params[:amount].to_i, # in cents
      description: "Data top up",
      currency:    "eur"
    )

    current_user.increment!(:balance, charge.amount * 1e7)

    redirect_to account_billing_path, notice: "Account balance was successfully topped up"
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to account_billing_path
  end

  private

  def create_customer
    if current_user.customer_id.nil?
      customer = Stripe::Customer.create(
        email:  current_user.email,
        source: charge_params[:token_id]
      )
      current_user.update(customer_id: customer.id)
    else
      customer = Stripe::Customer.retrieve(current_user.customer_id)
      customer.source = charge_params[:token_id]
      customer.save
    end
  end

  def charge_params
    params.permit(:amount, :token_id)
  end
end
