module Orderable
  extend ActiveSupport::Concern

  private

  def set_from
    if params[:from]
      @from = params[:from]
    elsif params[:album_token] || @album
      @from = params[:album_token] || @album.token
    elsif params[:user_username] || @user
      @from = 'user'
    elsif request.path == explore_path
      @from = 'explore'
    else
      @from = 'all'
    end
  end

  def set_order
    if params[:order]
      @order = params[:order]
    elsif request.path == explore_path
      @order = 'view'
    else
      @order = 'time'
    end
  end

  # TODO: move that method back to pictures controller
  def set_pictures
    case @from
    when 'all', 'explore'
      @pictures = Picture
    when 'user'
      @pictures = @user.pictures
    else
      @pictures = @album.pictures
    end
  end
end
