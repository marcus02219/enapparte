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

# == Schema Information
#
# Table name: addresses
#
#  id         :integer          not null, primary key
#  street     :string
#  postcode   :string
#  city       :string
#  state      :string
#  country    :string
#  latitude   :float
#  longitude  :float
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  is_primary :boolean          default(FALSE)
#
# Indexes
#
#  index_addresses_on_user_id  (user_id)
#
