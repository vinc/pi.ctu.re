class Admin::UsersController < Admin::AdminController
  def index
    @users = User.order(:username)
  end
end
