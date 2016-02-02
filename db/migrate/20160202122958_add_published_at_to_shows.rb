class AddPublishedAtToShows < ActiveRecord::Migration
  def change
    add_column :shows, :published_at, :datetime
  end
end
