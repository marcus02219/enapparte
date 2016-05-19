class AtrAddSer < ActiveRecord::Migration
  def up
    add_column :arts, :user_id, :integer, index: true
    User.all.each do |user|
      show_ids = user.show_ids
      art_ids = Show.where(id: show_ids).map(&:art_id)
      Art.where(id: art_ids).update_all(user_id: user.id)
    end
  end
  def down
    remove_column :arts, :user_id
  end
end
