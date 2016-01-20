# == Schema Information
#
# Table name: shows
#
#  id             :integer          not null, primary key
#  title          :string
#  length         :integer
#  description    :text
#  price          :float
#  max_spectators :integer
#  starts_at      :time
#  ends_at        :time
#  active         :boolean
#  user_id        :integer
#  art_id         :integer
#  language_id    :integer
#  bookings_id    :integer
#  pictures_id    :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Show < ActiveRecord::Base
  belongs_to :art
  belongs_to :user
  belongs_to :language
  has_many   :bookings  , dependent: :destroy
  has_many   :pictures  , dependent: :destroy , as: :imageable
end
