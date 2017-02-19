class RenamePictureDimensionsColumns < ActiveRecord::Migration[5.0]
  def change
    rename_column :pictures, :height, :image_height
    rename_column :pictures, :width,  :image_width
  end
end
