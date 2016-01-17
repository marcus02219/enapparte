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
