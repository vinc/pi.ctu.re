class PicturesController < ApplicationController
  include Orderable

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
    @pictures = Picture.where("caption ILIKE ?", "%#{params[:q]}%").page(params[:page]) if params[:q].present?

    respond_to do |format|
      format.html # search.html.erb
      format.js { render template: "pictures/index" }
    end
  end

  def import
  end

  def show
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

  def like
    @picture.liked_by(current_user)
    respond_to do |format|
      format.html { redirect_back(fallback_location: @picture) }
      format.json { head :no_content }
    end
  end

  def unlike
    @picture.unliked_by(current_user)
    respond_to do |format|
      format.html { redirect_back(fallback_location: @picture) }
      format.json { head :no_content }
    end
  end

  def feature
    authorize @picture

    @picture.update(is_featured: true)
    respond_to do |format|
      format.html { redirect_back(fallback_location: @picture) }
      format.json { head :no_content }
    end
  end

  def unfeature
    authorize @picture

    @picture.update(is_featured: false)
    respond_to do |format|
      format.html { redirect_back(fallback_location: @picture) }
      format.json { head :no_content }
    end
  end

  def lightbox
    Picture.increment_counter(:views_count, @picture.id)
  end

  private

  def set_picture
    @picture = Picture.find_by!(token: params[:token])
  end

  def set_user
    if params[:user_username]
      @user = User.find_by(username: params[:user_username])
    elsif @picture
      @user = @picture.user
    end
  end

  def set_album
    token = params[:album_token] || params[:from] unless %w[all explore user].include?(params[:from])

    @album = Album.find_by(token: token) if token
  end

  def picture_params
    params.require(:picture).permit(:caption, :image, album_ids: [])
  end
end
