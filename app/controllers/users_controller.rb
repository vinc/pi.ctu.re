class UsersController < ApplicationController
  include Orderable

  respond_to :html, :json, :js, :atom

  before_action :authenticate_user!, except: [:show]

  before_action :set_user

  before_action :set_from,             only: [:show]
  before_action :set_order,            only: [:show]

  def show
    @pictures = @user.pictures.order_by_time.page(params[:page])

    respond_with(@user) do |format|
      format.js { render template: "pictures/index" }
    end
  end

  def edit
  end

  def update
    @user.update(user_params)

    respond_with(@user)
  end

  def follow
    @user.followers << current_user
    respond_to do |format|
      format.html { redirect_back(fallback_location: @user) }
      format.json { head :no_content }
    end
  end

  def unfollow
    @user.followers.delete(current_user)
    respond_to do |format|
      format.html { redirect_back(fallback_location: @user) }
      format.json { head :no_content }
    end
  end

  private

  def set_user
    @user = User.find_by!(username: params[:username])
  end

  def user_params
    params.require(:user).permit(:fullname, :avatar)
  end
end
