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
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  firstname              :string
#  surname                :string
#  gender                 :integer
#  sex                    :integer
#  bio                    :text
#  phone_number           :string
#  provider               :string
#  uid                    :integer
#  dob                    :date
#  activity               :string
#  language_id            :integer
#  addresses_id           :integer
#  bookings_id            :integer
#  payment_methods_id     :integer
#  shows_id               :integer
#  picture_id             :integer
#  rating                 :float
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

require 'rails_helper'

describe User do
  let(:user) { create(:user)  }

  context '#rating' do
    let(:show) { create(:show, user: user) }
    let(:bookings) { create_list(:booking, 2, show: show) }

    before(:each) do
      bookings.each {|booking| create_list(:rating, 2, booking: booking) }
    end

    it { expect { create(:rating, booking: bookings.first) }.to change { user.reload; user.rating } }
    it { expect { bookings.first.ratings.first.destroy }.to change { user.reload; user.rating } }
    it { expect { bookings.first.ratings.first.update_attribute(:value, 0) }.to change { user.reload; user.rating } }

  end

  context 'when clear phone number all show deactivated' do
    let!(:shows) { create_list(:show, 2, active: true, user: user) }
    before(:each) do
      user.update_attribute :phone_number, ""
      user.reload
    end
    it { expect(user.shows.map(&:active)).to_not include(true)  }
  end

end
