class CreateAlbums < ActiveRecord::Migration[5.0]
  def change
    create_table :albums do |t|
      t.string :title
      t.string :token
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
