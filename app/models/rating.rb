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
  after_save :touch_parent
  after_destroy :touch_parent

  private

  def touch_parent
    if booking && booking.show
      booking.show.update_attribute(:updated_at, Time.now)
      if booking.show.user
        booking.show.user.update_attribute(:updated_at, Time.now)
      end
    end
  end
end
