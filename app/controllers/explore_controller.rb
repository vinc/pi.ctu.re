class ExploreController < ApplicationController
  include Orderable

  before_action :set_from,             only: [:index]
  before_action :set_order,            only: [:index]

  before_action :set_pictures,         only: [:index]

  def index
    case @order
    when 'view'
      @pictures = @pictures.featured.order_by_view.page(params[:page])
    when 'time'
      @pictures = @pictures.featured.order_by_time.page(params[:page])
    else
      raise ActionController::BadRequest, 'Invalid query parameters: order'
    end

    respond_to do |format|
      format.html # index.html.erb
      format.js { render template: 'pictures/index' }
    end
  end
end
