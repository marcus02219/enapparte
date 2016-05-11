FactoryGirl.define do
  factory :review do
    booking
    review { Faker::Lorem.sentence }
    after(:create) do |review|
      create(:rating, review: review)
    end
  end
end

# == Schema Information
#
# Table name: reviews
#
#  id         :integer          not null, primary key
#  review     :text
#  booking_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_reviews_on_booking_id  (booking_id)
#
