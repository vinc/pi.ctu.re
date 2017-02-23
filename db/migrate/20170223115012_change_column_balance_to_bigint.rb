class ChangeColumnBalanceToBigint < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :balance, :bigint
  end
end
