module Orderable
  extend ActiveSupport::Concern

  private

  def set_from
    @from =
      if params[:from] || params[:album_token] || @album
        params[:from] || params[:album_token] || @album.token
      elsif params[:user_username] || @user
        "user"
      elsif request.path == explore_path
        "explore"
      else
        "all"
      end
  end

  def set_order
    @order =
      if params[:order]
        params[:order]
      elsif request.path == explore_path
        "view"
      else
        "time"
      end
  end

  # TODO: move that method back to pictures controller
  def set_pictures
    @pictures =
      case @from
      when "all"
        Picture.where(privacy_setting: "public")
      when "explore"
        Picture.featured.where(privacy_setting: "public")
      when "user"
        if @user == current_user
          @user.pictures
        else
          @user.pictures.where(privacy_setting: "public")
        end
      else
        if @album.user == current_user
          @album.pictures
        else
          @album.pictures.where(privacy_setting: "public")
        end
      end
  end
end
