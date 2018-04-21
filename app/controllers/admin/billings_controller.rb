class Admin::BillingsController < Admin::AdminController
  def index
    @charges = Charge.history
  end
end
