FactoryGirl.define do
  factory :user do
    confirmed_at Time.now
    firstname Faker::Name.first_name
    surname Faker::Name.last_name
    email Faker::Internet.free_email
    gender { 1 }
    phone_number { '123-456-7890' }
    password "please123"
  end
end
