class UsersController < ApplicationController
  include Orderable

  before_action :authenticate_user!, except: [:show]

  before_action :set_user

  before_action :set_from,             only: [:show]
  before_action :set_order,            only: [:show]

  def show
    @pictures = @user.pictures.order_by_time.page(params[:page])

    respond_to do |format|
      format.html # show.html.erb
      format.js { render template: 'pictures/index' }
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  private

  def set_user
    @user = User.find_by(username: params[:username])
  end

  def user_params
    params.require(:user).permit(:fullname)
  end
end
