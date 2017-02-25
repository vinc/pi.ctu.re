class AddCustomerIdToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :customer_id, :string
  end
end
