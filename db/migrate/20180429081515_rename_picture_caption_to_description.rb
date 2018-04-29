class RenamePictureCaptionToDescription < ActiveRecord::Migration[5.2]
  def change
    rename_column :pictures, :caption, :description
  end
end
