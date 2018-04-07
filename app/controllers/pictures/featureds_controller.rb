class Pictures::FeaturedsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_picture

  def create
    authorize(@picture, "feature?")
    @picture.update(is_featured: true)
    respond_with(@picture, flash: false)
  end

  def destroy
    authorize(@picture, "unfeature?")
    @picture.update(is_featured: false)
    respond_with(@picture, flash: false)
  end

  private

  def set_picture
    @picture = Picture.find_by!(token: params[:picture_token])
  end
end
