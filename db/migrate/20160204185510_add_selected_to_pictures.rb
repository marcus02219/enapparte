class AddSelectedToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :selected, :boolean, default: false
  end
end
