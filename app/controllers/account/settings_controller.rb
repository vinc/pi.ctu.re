class Account::SettingsController < ApplicationController
  before_action :authenticate_user!

  def edit
  end

  def update
    current_user.update(user_params)
    I18n.locale = current_user.locale
    respond_with(current_user, location: edit_account_settings_path)
  end

  private

  def user_params
    params.require(:user).permit(:locale, :default_license, :default_privacy_setting)
  end
end
