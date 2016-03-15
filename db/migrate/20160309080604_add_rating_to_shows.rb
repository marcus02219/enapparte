class AddRatingToShows < ActiveRecord::Migration
  def change
    add_column :shows, :rating, :float
  end
end
