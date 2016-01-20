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

FactoryGirl.define do
  factory :payment_method do
    type ""
provider "MyString"
  end

end
