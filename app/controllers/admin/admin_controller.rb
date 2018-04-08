class Admin::AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :admin?

  def admin?
    current_user.admin?
  end
end
