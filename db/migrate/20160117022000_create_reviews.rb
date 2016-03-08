class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.text :review
      
      t.belongs_to :booking, index: true

      t.timestamps null: false
    end
  end
end