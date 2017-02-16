class AddIsFeaturedToPictures < ActiveRecord::Migration[5.0]
  def change
    add_column :pictures, :is_featured, :boolean, null: false, default: false
  end
end
