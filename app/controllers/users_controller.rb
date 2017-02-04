class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def show
    begin
      @pictures = Picture.order_by(params[:order].try(:to_sym))
    rescue ArgumentError
      raise ActionController::BadRequest, 'Invalid query parameters: order'
    end
  end

  private

  def set_user
    @user = User.find_by(username: params[:username])
  end
end
