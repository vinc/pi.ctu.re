class AddImageFilenameToPictures < ActiveRecord::Migration[5.0]
  def change
    add_column :pictures, :image_filename, :string
  end
end
