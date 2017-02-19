class AddAvatarFilenameToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :avatar_filename, :string
  end
end
