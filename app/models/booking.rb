# == Schema Information
#
# Table name: bookings
#
#  id                :integer          not null, primary key
#  status            :integer
#  date              :datetime
#  spectators        :integer
#  price             :float
#  message           :text
#  payout            :float
#  payment_received? :boolean
#  payment_sent?     :boolean
#  paid_on           :datetime
#  paid_out_on       :datetime
#  show_id           :integer
#  user_id           :integer
#  address_id        :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_bookings_on_address_id  (address_id)
#  index_bookings_on_show_id     (show_id)
#  index_bookings_on_user_id     (user_id)
#

class Booking < ActiveRecord::Base
  belongs_to :show
  belongs_to :user
  belongs_to :address
  has_one    :review

  just_define_datetime_picker :date
  just_define_datetime_picker :paid_on
  just_define_datetime_picker :paid_out_on

  alias_method :name, :id

  def change_status status
    if self.update status: status
      case status
      # accept
      when 1
        self.update_attributes(
          payment_received?: true,
          paid_out_on: Time.new
        )
        PerformerMailer.booking_accepted(self).deliver_now
        UserMailer.booking_accepted(self).deliver_now
      # cancel
      when 3
        PerformerMailer.booking_cancelled(self).deliver_now
        UserMailer.booking_cancelled(self).deliver_now
      end
    end
  end

  def self.check_expired
    Booking.where('status = 2 and date > ?', 48.hours.ago).update_all status: 4
  end
end

