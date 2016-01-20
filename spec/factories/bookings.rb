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

FactoryGirl.define do
  factory :booking do
    status 1
date "2016-01-17 05:15:16"
spectators 1
price 1.5
message "MyText"
payout 1.5
payment_received? false
payment_sent? false
paid_on "2016-01-17 05:15:16"
paid_out_on "2016-01-17 05:15:16"
  end

end
