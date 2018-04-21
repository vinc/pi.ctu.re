class AddCachedVotesToPictures < ActiveRecord::Migration[5.2]
  def change
    add_column :pictures, :cached_votes_total, :integer, default: 0

    Picture.find_each(&:update_cached_votes)
  end
end
