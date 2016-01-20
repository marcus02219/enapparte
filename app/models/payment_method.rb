# == Schema Information
#
# Table name: payment_methods
#
#  id          :integer          not null, primary key
#  payoption   :string
#  provider    :string
#  user_id     :integer
#  bookings_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class PaymentMethod < ActiveRecord::Base
  belongs_to :user
  has_many   :bookings
end
