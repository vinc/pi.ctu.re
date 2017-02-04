class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update, :destroy, :like, :unlike]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @pictures = case params[:sort] || 'top'
    when 'top'
      Picture.order(:views_count => :desc)
    when 'new'
      Picture.order(:created_at => :desc)
    else
      raise ActionController::BadRequest, 'Invalid query parameters: sort'
    end
  end

  def show
    Picture.increment_counter(:views_count, @picture.id)
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
      format.html { redirect_to @picture }
      format.json { head :no_content }
    end
  end

  def unlike
    @picture.unliked_by(current_user)
    respond_to do |format|
      format.html { redirect_to @picture }
      format.json { head :no_content }
    end
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
