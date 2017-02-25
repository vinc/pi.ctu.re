class Account::ChargesController < ApplicationController
  before_action :authenticate_user!

  def create
    @amount = charge_params[:amount] # in cents

    customer = Stripe::Customer.create(
      email:  current_user.email,
      source: charge_params[:token_id]
    )

    charge = Stripe::Charge.create(
      customer:    customer.id,
      amount:      @amount,
      description: 'Data top up',
      currency:    'usd'
    )

    current_user.increment!(:balance, charge.amount * 1e7)

    redirect_to account_billing_path, notice: 'Account balance was successfully topped up'

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to account_billing_path
  end

  private

  def charge_params
    params.permit(:amount, :token_id)
  end
end
