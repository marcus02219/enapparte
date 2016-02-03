# == Schema Information
#
# Table name: shows
#
#  id               :integer          not null, primary key
#  title            :string
#  length           :integer
#  description      :text
#  price            :float
#  max_spectators   :integer
#  active           :boolean
#  user_id          :integer
#  art_id           :integer
#  language_id      :integer
#  bookings_id      :integer
#  pictures_id      :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  cover_picture_id :integer
#  published_at     :datetime
#  starts_at        :string
#  ends_at          :string
#

FactoryGirl.define do
  factory :show do
    title { Faker::Lorem.sentence }
    length { Faker::Number.number(2) }
    description { Faker::Lorem.paragraph }
    price { Faker::Number.number(2) }
    max_spectators { Faker::Number.number(2) }
    starts_at { "2016-01-17 05:17:54" }
    ends_at { "2016-01-17 05:17:54" }
    active { false }

    art
    language
  end

end
