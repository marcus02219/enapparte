class AddIsPrimaryToAddresses < ActiveRecord::Migration
  def change
    add_column :addresses, :is_primary, :boolean, default: false
  end
end
