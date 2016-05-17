class CreateShowcases < ActiveRecord::Migration
  def change
    create_table :showcases do |t|
      t.references :user
      t.string :kind
      t.string :url

      t.timestamps null: false
    end
  end
end
