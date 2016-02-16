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

    factory :show_with_rating do
      after(:create) do |show|
        3.times do
          booking = Booking.create(
            user: User.all.reject {|u| u.id == show.user.try(:id) }.to_a.sample,
            show: show,
            status: Faker::Number.between(1, 4),
            date: Faker::Time.between(1.days.ago, 10.days.from_now),
            spectators: Faker::Number.between(1, 100),
            price: Faker::Number.decimal(5,2),
            message: Faker::Lorem.sentence,
            payout: Faker::Number.decimal(5,2)
          )
          3.times.each do
            Rating.create(
              booking: booking,
              value: Faker::Number.between(1, 5)
            )
          end
          show.bookings << booking
        end
      end
    end
  end

end
