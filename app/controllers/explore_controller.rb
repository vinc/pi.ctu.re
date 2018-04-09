class ExploreController < PicturesController
  def index
    super

    respond_to do |format|
      format.html # index.html.erb
      format.js { render template: "pictures/index" }
    end
  end
end
