class AlbumsController < ApplicationController
  include Orderable

  before_action :authenticate_user!, except: %i[index show]

  before_action :set_album,            only: %i[show edit update destroy]
  before_action :set_user,             only: %i[index show]

  before_action :set_from,             only: [:show]
  before_action :set_order,            only: [:show]

  def index
    @albums = (@user ? @user.albums : Album).order_by_time
  end

  def show
    @pictures = @album.pictures.order_by_time.page(params[:page])

    respond_to do |format|
      format.html # show.html.erb
      format.js { render template: "pictures/index" }
    end
  end

  def new
    @album = current_user.albums.new
  end

  def edit
  end

  def create
    @album = current_user.albums.create(album_params)
    respond_with(@album)
  end

  def update
    # NOTE: `updated_at` is not automatically changed when adding pictures
    # to album without changing anything else.
    @album.update(album_params.merge(updated_at: Time.current))
    respond_with(@album)
  end

  def destroy
    @album.destroy
    respond_with(@album)
  end

  private

  def set_album
    @album = Album.find_by!(token: params[:token])
  end

  def set_user
    if @album
      @user = @album.user
    elsif params[:user_username]
      @user = User.find_by(username: params[:user_username])
    end
  end

  def album_params
    params.require(:album).permit(:title, :token, :user_id, picture_ids: [])
  end
end
