class CreateInvitations < ActiveRecord::Migration[5.0]
  def change
    create_table :invitations do |t|
      t.string :token
      t.string :email
      t.datetime :approved_at

      t.timestamps
    end
    add_index :invitations, :token, unique: true
  end
end
