FactoryGirl.define do
  factory :rating do
    value { Faker::Number.between(1, 5) }
  end
end

# == Schema Information
#
# Table name: ratings
#
#  id         :integer          not null, primary key
#  value      :integer
#  review_id  :integer
#  user_id    :integer
#  booking_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_ratings_on_booking_id  (booking_id)
#  index_ratings_on_review_id   (review_id)
#  index_ratings_on_user_id     (user_id)
#
