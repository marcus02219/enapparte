class AddDateAtToShow < ActiveRecord::Migration
  def change
    add_column :shows, :date_at, :datetime
  end
end
