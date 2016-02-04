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

end
