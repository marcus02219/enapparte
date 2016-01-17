class CreatePaymentMethods < ActiveRecord::Migration
  def change
    create_table :payment_methods do |t|
      t.string :payoption
      t.string :provider
      t.references :user
      t.references :bookings
      t.timestamps null: false
    end
  end
end
