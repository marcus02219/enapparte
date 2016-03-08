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

      t.belongs_to :show, index: true
      t.belongs_to :user, index: true
      t.belongs_to :address, index: true

      t.timestamps null: false
    end
  end
end
