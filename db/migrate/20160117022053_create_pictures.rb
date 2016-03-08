class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :title
      t.boolean :selected
      t.string :imageable_type
      
      t.references :imageable, polymorphic: true, index: true
      
      t.timestamps null: false
    end
  end
end
