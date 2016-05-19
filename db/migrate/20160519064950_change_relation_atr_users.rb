class ChangeRelationAtrUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :art_id, :integer
    Art.all.each do |art|
      user = User.find_by(id: art.user_id) if art.user_id
      user.update_attribute(:art_id, art.id) if user
    end
  end

  def self.down
    remove_column :users, :art_id
  end
end
