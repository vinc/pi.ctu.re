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
end
