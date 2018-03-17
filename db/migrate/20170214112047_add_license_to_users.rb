class AddLicenseToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :default_license, :string, null: false, default: "CC BY-NC-ND"
  end
end
