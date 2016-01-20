class AddImageableTypeToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :imageable_type, :string
  end
end
