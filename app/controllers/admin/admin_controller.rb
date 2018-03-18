class Admin::AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :is_admin?

  def is_admin?
    current_user.is_admin?
  end
end
