class UsersController < ApplicationController
  include PaginationContext

  respond_to :html, :json, :js, :atom

  before_action :authenticate_user!, except: %i[show followers followees]

  before_action :set_user

  before_action :set_from,             only: :show
  before_action :set_order,            only: :show

  def show
    @pictures = @user.pictures.order_by_time.page(params[:page])
    @pictures = @pictures.public_setting unless @user == current_user

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

  def followers
    @followers = User.joins(:followee_relationships).
      where("follows.followee_id = ?", @user.id).
      order("follows.created_at DESC").
      page(1).per(100)
  end

  def followees
    @followees = User.joins(:follower_relationships).
      where("follows.follower_id = ?", @user.id).
      order("follows.created_at DESC").
      page(1).per(100)
  end

  private

  def set_user
    @user = User.find_by!(username: params[:username])
  end

  def user_params
    params.require(:user).permit(:fullname, :avatar)
  end
end
