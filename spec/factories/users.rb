# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  role                   :integer          default(1)
#  firstname              :string
#  surname                :string
#  gender                 :integer
#  bio                    :text
#  phone_number           :string
#  dob                    :date
#  activity               :string
#  moving                 :boolean
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

FactoryGirl.define do
  factory :user do
    # confirmed_at Time.now
    firstname Faker::Name.first_name
    surname Faker::Name.last_name
    email { Faker::Internet.free_email }
    gender { User.genders.keys.sample }
    phone_number { Faker::Number.number(10).gsub(/(\d{3})(\d{3})(\d{4})/, '\1-\2-\3') }
    dob { Faker::Time.backward(14000, :evening).to_date }
    password '123'*3
    activity { Faker::Lorem.sentence }
    bio { Faker::Lorem.sentence }

    after(:create) do |user|
      create :address, user: user
    end

    factory :user_with_picture do
      after(:create) do |user|
        create :address, user: user
        user.picture.image = File.open Rails.root.join('spec/fixtures/photo.jpeg')
        user.picture.save
      end
    end
  end
end
