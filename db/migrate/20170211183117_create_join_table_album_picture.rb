class CreateJoinTableAlbumPicture < ActiveRecord::Migration[5.0]
  def change
    create_join_table :albums, :pictures do |t|
      # t.index [:album_id, :picture_id]
      # t.index [:picture_id, :album_id]
    end
  end
end
