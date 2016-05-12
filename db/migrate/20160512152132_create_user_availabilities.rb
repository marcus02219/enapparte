class CreateUserAvailabilities < ActiveRecord::Migration
  def change
    create_table :user_availabilities do |t|
      t.references :user
      t.date :available_at

      t.timestamps null: false
    end
  end
end
