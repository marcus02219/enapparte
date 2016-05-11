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

    factory :show_with_rating do
      after(:create) do |show|
        3.times do
          booking = create :booking_with_rating, show: show
        end
      end
    end
  end

end

# == Schema Information
#
# Table name: shows
#
#  id               :integer          not null, primary key
#  title            :string
#  length           :integer
#  surface          :integer
#  description      :text
#  price            :float
#  max_spectators   :integer
#  starts_at        :string
#  ends_at          :string
#  active           :boolean
#  published_at     :datetime
#  cover_picture_id :integer
#  user_id          :integer
#  art_id           :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  rating           :float
#  price_person     :boolean
#  date_at          :datetime
#
# Indexes
#
#  index_shows_on_art_id            (art_id)
#  index_shows_on_cover_picture_id  (cover_picture_id)
#  index_shows_on_user_id           (user_id)
#
