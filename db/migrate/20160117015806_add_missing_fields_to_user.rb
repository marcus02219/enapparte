class AddMissingFieldsToUser < ActiveRecord::Migration
  def change
    change_table  :users do |t|
      t.integer :sex
      t.text    :bio
      t.string  :phone_number
      t.string  :provider
      t.integer :uid
      t.date    :dob
      t.string  :activity
=begin
      belongs_to
=end
      t.references :language
=begin
      has_many
=end
      t.references :addresses
      t.references :bookings
      t.references :payment_methods
      t.references :shows
=begin
     has_one
=end
      t.references :picture
    end
  end
end
