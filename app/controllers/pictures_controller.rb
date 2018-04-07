class PicturesController < ApplicationController
  include PaginationContext

  before_action :authenticate_user!, except: %i[index search show lightbox]

  before_action :set_picture,        except: %i[index import search new create]
  before_action :set_album,            only: %i[index show lightbox]
  before_action :set_user,             only: %i[index show lightbox]

  before_action :set_from,             only: %i[index show lightbox]
  before_action :set_order,            only: %i[index show lightbox]

  before_action :set_pictures,         only: %i[index show lightbox]

  def index
    case @order
    when "view"
      @pictures = @pictures.order_by_view.page(params[:page])
    when "time"
      @pictures = @pictures.order_by_time.page(params[:page])
    else
      raise ActionController::BadRequest, "Invalid query parameters: order"
    end
  end

  def search
    if params[:q].present?
      @pictures = Picture.
        where(privacy_setting: "public").
        where("caption ILIKE ?", "%#{params[:q]}%").page(params[:page])
    end

    respond_to do |format|
      format.html # search.html.erb
      format.js { render template: "pictures/index" }
    end
  end

  def import
  end

  def show
    @picture.protected_param = params[:secret]
    authorize @picture

    case @order
    when "view"
      @previous_picture = @pictures.order_by_view_at(@picture).previous(false)
      @next_picture     = @pictures.order_by_view_at(@picture).next(false)
    else
      @previous_picture = @pictures.order_by_time_at(@picture).previous(false)
      @next_picture     = @pictures.order_by_time_at(@picture).next(false)
    end

    Picture.increment_counter(:views_count, @picture.id)
  end

  def lightbox
    show
  end

  def new
    @picture = current_user.pictures.new
  end

  def edit
  end

  def create
    @picture = current_user.pictures.create(picture_params)
    respond_with(@picture)
  end

  def update
    @picture.update(picture_params)
    respond_with(@picture)
  end

  def destroy
    @picture.destroy
    respond_with(@picture)
  end

  private

  def set_picture
    @picture = Picture.find_by!(token: params[:token])
  end

  def set_album
    token = params[:album_token] || params[:from] unless %w[all explore user].include?(params[:from])

    @album = Album.find_by(token: token) if token
  end

  def set_user
    @user = @picture.user unless @picture.nil?
  end

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
      when /\w+/ # album token
        raise(ActionController::BadRequest, "Invalid query parameters: from") if @album.nil?

        if @album.user == current_user
          @album.pictures
        else
          @album.pictures.where(privacy_setting: "public")
        end
      end
  end

  def picture_params
    params.require(:picture).permit(:caption, :image, :privacy_setting, :regenerate_secret, album_ids: [])
  end
end
