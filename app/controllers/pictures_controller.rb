class PicturesController < ApplicationController
  before_action :set_picture,        except: [:index, :new, :create]
  before_action :authenticate_user!, except: [:index, :show, :lightbox]

  def index
    @show_picture_from = 'explore'
    @show_picture_order = params[:order] || 'view'

    case @show_picture_order
    when 'view'
      @pictures = Picture.order_by_view.page(params[:page])
    when 'time'
      @pictures = Picture.order_by_time.page(params[:page])
    else
      raise ActionController::BadRequest, 'Invalid query parameters: order'
    end
  end

  def show
    @show_picture_from = params[:from] || 'user'
    @show_picture_order = params[:order] || 'time'

    pictures = (params[:from] == 'explore' ? Picture : @picture.user.pictures)

    case params[:order]
    when 'view'
      @previous_picture = pictures.order_by_view_at(@picture).previous(false)
      @next_picture     = pictures.order_by_view_at(@picture).next(false)
    else
      @previous_picture = pictures.order_by_time_at(@picture).previous(false)
      @next_picture     = pictures.order_by_time_at(@picture).next(false)
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
    @show_picture_from = params[:from] || 'user'
    @show_picture_order = params[:order] || 'time'
    Picture.increment_counter(:views_count, @picture.id)
    @picture.charge_user(:large)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_picture
      @picture = Picture.find_by(token: params[:token])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def picture_params
      params.require(:picture).permit(:caption, :image)
    end
end
