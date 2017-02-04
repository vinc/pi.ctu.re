class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def show
    @pictures = @user.pictures.order_by(:time).page(params[:page])
  end

  private

  def set_user
    @user = User.find_by(username: params[:username])
  end
end
