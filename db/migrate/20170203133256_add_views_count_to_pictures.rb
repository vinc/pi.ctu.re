class AddViewsCountToPictures < ActiveRecord::Migration[5.0]
  def change
    add_column :pictures, :views_count, :integer, default: 0, null: false
  end
end
