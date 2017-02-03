class AddTokenToPictures < ActiveRecord::Migration[5.0]
  def change
    add_column :pictures, :token, :string
    add_index :pictures, :token, unique: true
  end
end
