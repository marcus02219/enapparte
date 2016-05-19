class CreateShows < ActiveRecord::Migration
  def change
    create_table :shows do |t|
      t.string :title
      t.integer :length
      t.integer :surface
      t.text :description
      t.float :price
      t.integer :max_spectators
      t.string :starts_at
      t.string :ends_at
      t.boolean :active
      t.datetime :published_at
      t.integer :cover_picture_id

      t.belongs_to :user, index: true
      t.belongs_to :cover_picture, index: true

      t.timestamps null: false
    end
  end
end
