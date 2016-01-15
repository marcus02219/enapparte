class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :firstname, :string
    add_column :users, :surname, :string
    add_column :users, :gender, :integer
  end
end
