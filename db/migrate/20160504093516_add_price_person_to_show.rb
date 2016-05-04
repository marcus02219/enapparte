class AddPricePersonToShow < ActiveRecord::Migration
  def change
    add_column :shows, :price_person, :boolean
  end
end
