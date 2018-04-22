class AddStatusToPicture < ActiveRecord::Migration[5.2]
  def change
    add_column :pictures, :status, :integer, default: 0
  end
end
