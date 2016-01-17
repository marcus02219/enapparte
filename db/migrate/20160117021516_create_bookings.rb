class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.integer :status
      t.datetime :date
      t.integer :spectators
      t.float :price
      t.text :message
      t.float :payout
      t.boolean :payment_received?
      t.boolean :payment_sent?
      t.datetime :paid_on
      t.datetime :paid_out_on
=begin
      belongs_to
=end
      t.references :show
      t.references :user
      t.references :address
      t.references :payment_methods
=begin
      has_many
=end
      t.references :ratings
=begin
      has_one
=end
      t.references :comment



      t.timestamps null: false
    end
  end
end
