class Pictures::LightboxesController < PicturesController
  private

  def set_picture
    @picture = Picture.find_by!(token: params[:picture_token])
  end
end
