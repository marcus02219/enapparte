class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :postcode
      t.string :city
      t.string :state
      t.string :country
      t.float :latitude
      t.float :longitude
      t.belongs_to :user, index: true
      t.timestamps null: false
    end
  end
end
