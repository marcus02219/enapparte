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

FactoryGirl.define do
  factory :payment_method do
    type ""
provider "MyString"
  end

end
