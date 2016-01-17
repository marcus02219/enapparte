class CreateLanguages < ActiveRecord::Migration
  def change
    create_table :languages do |t|
      t.string :title
      t.references :users
      t.references :shows
      t.timestamps null: false
    end
  end
end
