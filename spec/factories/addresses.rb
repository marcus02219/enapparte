# == Schema Information
#
# Table name: addresses
#
#  id          :integer          not null, primary key
#  street      :string
#  postcode    :string
#  city        :string
#  state       :string
#  country     :string
#  latitude    :float
#  longitude   :float
#  user_id     :integer
#  bookings_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :address do
    street "MyString"
postcode "MyString"
city "MyString"
state "MyString"
country "MyString"
latitude 1.5
longitude 1.5
  end

end
