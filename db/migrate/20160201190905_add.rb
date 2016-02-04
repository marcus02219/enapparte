class Add < ActiveRecord::Migration
  def change
    add_column :shows, :cover_picture_id, :integer
  end
end
