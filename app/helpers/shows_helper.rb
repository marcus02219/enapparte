# == Schema Information
#
# Table name: shows
#
#  id               :integer          not null, primary key
#  title            :string
#  length           :integer
#  surface          :integer
#  description      :text
#  price            :float
#  max_spectators   :integer
#  starts_at        :string
#  ends_at          :string
#  active           :boolean
#  published_at     :datetime
#  cover_picture_id :integer
#  user_id          :integer
#  art_id           :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_shows_on_art_id            (art_id)
#  index_shows_on_cover_picture_id  (cover_picture_id)
#  index_shows_on_user_id           (user_id)
#

module ShowsHelper
end
