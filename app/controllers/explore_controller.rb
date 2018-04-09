class ExploreController < PicturesController
  def index
    @pictures = Picture.featured.public_setting

    super

    respond_to do |format|
      format.html # index.html.erb
      format.js { render template: "pictures/index" }
    end
  end
end
