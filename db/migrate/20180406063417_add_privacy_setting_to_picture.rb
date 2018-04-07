class AddPrivacySettingToPicture < ActiveRecord::Migration[5.1]
  def change
    add_column :pictures, :privacy_setting, :int, default: 0
  end
end
