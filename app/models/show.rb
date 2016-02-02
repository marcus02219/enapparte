# == Schema Information
#
# Table name: shows
#
#  id               :integer          not null, primary key
#  title            :string
#  length           :integer
#  description      :text
#  price            :float
#  max_spectators   :integer
#  active           :boolean
#  user_id          :integer
#  art_id           :integer
#  language_id      :integer
#  bookings_id      :integer
#  pictures_id      :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  cover_picture_id :integer
#  published_at     :datetime
#  starts_at        :string
#  ends_at          :string
#

class Show < ActiveRecord::Base
  belongs_to :art
  belongs_to :user
  belongs_to :language
  has_many   :bookings  , dependent: :destroy
  has_many   :pictures  , dependent: :destroy , as: :imageable
  belongs_to :cover_picture, class_name: 'Picture'
end
