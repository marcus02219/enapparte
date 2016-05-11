require 'rails_helper'

RSpec.describe Show, type: :model do

  context 'accepts_nested_attributes_for :pictures' do
    let(:show) { build :show }
    it 'creates picture' do
      expect {
        show.pictures_attributes = [ { src: File.read(Rails.root.join('spec/fixtures/base64data.txt')) } ]
        show.save
      }.to change { Picture.count }.by(1)
    end
  end

  context '#toggle_active' do
    context 'when email is not confirmed' do
      let(:user) { create :user }
      let(:show) { create :show, user: user }
      before(:each) { show.toggle_active }
      it { expect(show.active).to eq true }
    end

    # context 'when email is not confirmed' do
    #   let(:user) { create :user, confirmed_at: nil }
    #   let(:show) { create :show, user: user }
    #   before(:each) { show.toggle_active }
    #   it { expect(show.active).to eq false }
    # end

    context 'when address is not filled' do
      let(:user) { create :user, addresses: [] }
      let(:show) { create :show, user: user }
      before(:each) { show.toggle_active }
      it { expect(show.active).to eq false }
    end

    context 'when phone is not filled' do
      let(:user) { create :user, phone_number: nil }
      let(:show) { create :show, user: user }
      before(:each) { show.toggle_active }
      it { expect(show.active).to eq false }
    end
  end

  context '#rating' do
    let(:show) { create(:show) }
    let!(:bookings) { create_list(:booking_with_rating, 5, show: show) }

    it { expect { create(:rating, review: bookings.first.review) }.to change { show.reload; show.rating } }
    it { expect { bookings.first.review.rating.destroy }.to change { show.reload; show.rating } }
    it { expect { bookings.first.review.destroy }.to change { show.reload; show.rating } }
    it { expect { bookings.first.review.rating.update_attribute(:value, 0) }.to change { show.reload; show.rating } }
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
