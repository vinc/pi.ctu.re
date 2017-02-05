class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def show
    @pictures = @user.pictures.order_by_time.page(params[:page])

    respond_to do |format|
      format.html # show.html.erb
      format.js { render template: 'pictures/index' }
    end
  end

  private

  def set_user
    @user = User.find_by(username: params[:username])
  end
end
