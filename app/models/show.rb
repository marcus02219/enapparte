class Show < ActiveRecord::Base
  belongs_to :art
  belongs_to :user
  belongs_to :language
  has_many   :bookings  , dependent: :destroy
  has_many   :pictures  , dependent: :destroy , as: :imageable
end
