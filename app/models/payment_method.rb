class PaymentMethod < ActiveRecord::Base
  belongs_to :user
  has_many   :bookings
end

# == Schema Information
#
# Table name: payment_methods
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  booking_id   :integer
#  stripe_token :string
#  last4        :string
#
# Indexes
#
#  index_payment_methods_on_booking_id  (booking_id)
#  index_payment_methods_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_bd7caa08e7  (booking_id => bookings.id)
#  fk_rails_e13d4c515f  (user_id => users.id)
#
