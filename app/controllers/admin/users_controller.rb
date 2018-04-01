class Admin::UsersController < Admin::AdminController
  def index
    @users = User.order(created_at: :desc)
  end
end
