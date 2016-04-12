class CreatePaymentMethods < ActiveRecord::Migration
  def change
    create_table :payment_methods do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :booking, index: true, foreign_key: true
      t.string :stripe_token
      t.string :last4
    end
  end
end
