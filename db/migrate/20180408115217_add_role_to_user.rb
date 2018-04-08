class AddRoleToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :role, :integer, default: 0
    remove_column :users, :is_admin
  end
end
