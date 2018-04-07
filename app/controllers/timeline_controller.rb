class TimelineController < ApplicationController
  respond_to :html, :js, :atom

  before_action :authenticate_user!

  def index
    @pictures = Picture.
      where(privacy_setting: "public", user: current_user.followees + [current_user]).
      order_by_time.page(params[:page])
  end
end
