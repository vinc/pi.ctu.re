class StoreImagesInDatabase < ActiveRecord::Migration[5.0]
  def change
    remove_column :users,    :avatar
    remove_column :pictures, :image

    add_column    :users,    :avatar, :oid
    add_column    :pictures, :image,  :oid, null: false
  end
end
