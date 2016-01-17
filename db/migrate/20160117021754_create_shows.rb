class CreateShows < ActiveRecord::Migration
  def change
    create_table :shows do |t|
      t.string :title
      t.integer :length
      t.text :description
      t.float :price
      t.integer :max_spectators
      t.time :starts_at
      t.time :ends_at
      t.boolean :active
=begin
      belongs_to
=end
      t.references :user
      t.references :art
      t.references :language
=begin
      has_many
=end
      t.references :bookings
      t.references :pictures

      t.timestamps null: false
    end
  end
end
