class Account::BillingsController < ApplicationController
  before_action :authenticate_user!

  def show
    @charges = Charge.history(user: current_user)
  end
end
