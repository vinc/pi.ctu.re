class Pictures::LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_picture

  def create
    @picture.liked_by(current_user)
    respond_with(@picture, flash: false)
  end

  def destroy
    @picture.unliked_by(current_user)
    respond_with(@picture, flash: false)
  end

  private

  def set_picture
    @picture = Picture.find_by!(token: params[:picture_token])
  end
end
