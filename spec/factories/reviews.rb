FactoryGirl.define do
  factory :review do
    booking
    review { Faker::Lorem.sentence }
  end
end
