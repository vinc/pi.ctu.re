class CreateFollows < ActiveRecord::Migration[5.1]
  def change
    create_table :follows do |t|
      t.integer :follower_id, index: true
      t.integer :followee_id, index: true

      t.timestamps
    end

    add_foreign_key :follows, :users, column: :follower_id
    add_foreign_key :follows, :users, column: :followee_id

    add_column :users, :followers_count, :integer, default: 0
    add_column :users, :followees_count, :integer, default: 0
  end
end
