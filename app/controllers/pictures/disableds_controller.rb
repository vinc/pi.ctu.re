class Pictures::DisabledsController < Admin::AdminController
  before_action :set_picture

  def create
    @picture.update(status: "disabled")
    respond_with(@picture, flash: false)
  end

  def destroy
    @picture.update(status: "enabled")
    respond_with(@picture, flash: false)
  end

  private

  def set_picture
    @picture = Picture.find_by!(token: params[:picture_token])
  end
end
