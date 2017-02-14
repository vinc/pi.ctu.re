class Account::SettingsController < ApplicationController
  before_action :authenticate_user!

  def edit
  end

  def update
    respond_to do |format|
      if current_user.update(user_params)
        format.html { redirect_to edit_account_settings_path, notice: 'Settings were successfully updated.' }
        format.json { render :show, status: :ok, location: edit_account_settings_path }
      else
        format.html { render :edit }
        format.json { render json: current_user.errors, status: :unprocessable_entity }
      end
    end
  end


  private

  def user_params
    params.require(:user).permit(:default_license)
  end
end
