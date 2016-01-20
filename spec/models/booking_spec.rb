# == Schema Information
#
# Table name: bookings
#
#  id                 :integer          not null, primary key
#  status             :integer
#  date               :datetime
#  spectators         :integer
#  price              :float
#  message            :text
#  payout             :float
#  payment_received?  :boolean
#  payment_sent?      :boolean
#  paid_on            :datetime
#  paid_out_on        :datetime
#  show_id            :integer
#  user_id            :integer
#  address_id         :integer
#  payment_methods_id :integer
#  ratings_id         :integer
#  comment_id         :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'rails_helper'

RSpec.describe Booking, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
