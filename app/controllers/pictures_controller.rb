class PicturesController < ApplicationController
  include Orderable

  before_action :authenticate_user!, except: [:index, :search, :show, :lightbox]

  before_action :set_picture,        except: [:index, :new, :create]
  before_action :set_album,            only: [:index, :show, :lightbox]
  before_action :set_user,             only: [:index, :show, :lightbox]

  before_action :set_from,             only: [:index, :show, :lightbox]
  before_action :set_order,            only: [:index, :show, :lightbox]

  before_action :set_pictures,         only: [:index, :show, :lightbox]

  def index
    case @order
    when 'view'
      @pictures = @pictures.order_by_view.page(params[:page])
    when 'time'
      @pictures = @pictures.order_by_time.page(params[:page])
    else
      raise ActionController::BadRequest, 'Invalid query parameters: order'
    end
  end

  def search
    if params[:q].present?
      @pictures = Picture.where('caption ILIKE ?', "%#{params[:q]}%").page(params[:page])
    end

    respond_to do |format|
      format.html # search.html.erb
      format.js { render template: 'index' }
    end
  end

  def show
    case @order
    when 'view'
      @previous_picture = @pictures.order_by_view_at(@picture).previous(false)
      @next_picture     = @pictures.order_by_view_at(@picture).next(false)
    else
      @previous_picture = @pictures.order_by_time_at(@picture).previous(false)
      @next_picture     = @pictures.order_by_time_at(@picture).next(false)
    end

    Picture.increment_counter(:views_count, @picture.id)

    @picture.charge_user(:large)
  end

  def new
    @picture = current_user.pictures.new
  end

  def edit
  end

  def create
    @picture = current_user.pictures.new(picture_params)

    respond_to do |format|
      if @picture.save
        @picture.charge_user

        format.html { redirect_to @picture, notice: 'Picture was successfully created.' }
        format.json { render :show, status: :created, location: @picture }
      else
        format.html { render :new }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @picture.update(picture_params)
        format.html { redirect_to @picture, notice: 'Picture was successfully updated.' }
        format.json { render :show, status: :ok, location: @picture }
      else
        format.html { render :edit }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @picture.destroy
    respond_to do |format|
      format.html { redirect_to pictures_url, notice: 'Picture was successfully destroyed.' }
      format.json { head :no_content }
    end
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

  def lightbox
    Picture.increment_counter(:views_count, @picture.id)
    @picture.charge_user(:large)
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
    token = params[:album_token] ||
            params[:from] unless %w(all explore user).include?(params[:from])

    if token
      @album = Album.find_by(token: token)
    end
  end

  def picture_params
    params.require(:picture).permit(:caption, :image, album_ids: [])
  end
end
