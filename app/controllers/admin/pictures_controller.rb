class Admin::PicturesController < Admin::AdminController
  def index
    @pictures = Picture.disabled.order_by_time
  end
end
