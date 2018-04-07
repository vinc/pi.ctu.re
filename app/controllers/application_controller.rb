require "application_responder"

class ApplicationController < ActionController::Base
  include Pundit

  self.responder = ApplicationResponder
  respond_to :html, :json

  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  def pundit_user
    current_user || User.new # guest user
  end

  protected

  def configure_permitted_parameters
    added_attrs = %i[invitation_token username email password password_confirmation remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
