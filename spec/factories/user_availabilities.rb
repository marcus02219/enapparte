FactoryGirl.define do
  factory :user_availability do
    user
    available_at { Date.today }
  end
end

# == Schema Information
#
# Table name: user_availabilities
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  available_at :date
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
