class ChangeStartsAndEndsAtInShows < ActiveRecord::Migration
  def change
    remove_column :shows, :starts_at
    remove_column :shows, :ends_at
    add_column :shows, :starts_at, :string
    add_column :shows, :ends_at, :string
  end
end
