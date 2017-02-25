class Account::ChargesController < ApplicationController
  before_action :authenticate_user!

  def create
    @amount = charge_params[:amount] # in cents

    if current_user.customer_id.nil?
      customer = Stripe::Customer.create(
        email:  current_user.email,
        source: charge_params[:token_id]
      )
      current_user.update(customer_id: customer.id)
    end

    charge = Stripe::Charge.create(
      customer:    current_user.customer_id,
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
