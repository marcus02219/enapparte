class RemoveRatingFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :rating
  end
end
