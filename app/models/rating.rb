# == Schema Information
#
# Table name: ratings
#
#  id         :integer          not null, primary key
#  value      :integer
#  booking_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Rating < ActiveRecord::Base
  belongs_to :booking
  after_save :touch_user
  after_destroy :touch_user

  private

  def touch_user
    if booking && booking.show && booking.show.user
      booking.show.user.update_attribute(:updated_at, Time.now)
    end
  end
end
