require 'rails_helper'

RSpec.describe Address, type: :model do

  # context '#set_is_primary' do
  #   let(:user) { create(:user) }
  #   it { user.reload; expect(user.addresses.first.is_primary).to be true }

  #   context 'added second address' do
  #     let!(:address) { create :address, user: user }

  #     it { user.reload; expect(user.addresses.last.is_primary).to_not eq true }
  #   end

  #   context 'create a new address as a primary' do
  #     let!(:address) { create :address, user: user, is_primary: true }

  #     it { user.reload; expect(user.addresses.first.is_primary).to_not eq true }
  #     it { user.reload; expect(user.addresses.last.is_primary).to eq true }
  #   end

  #   context 'set an address as a primary' do
  #     let!(:address) { create :address, user: user }

  #     it do
  #       expect {
  #         user.addresses.last.update_attribute :is_primary, true
  #       }.to change { user.reload; user.addresses.first.is_primary }
  #     end

  #   end
  # end

end

# == Schema Information
#
# Table name: addresses
#
#  id         :integer          not null, primary key
#  street     :string
#  postcode   :string
#  city       :string
#  state      :string
#  country    :string
#  latitude   :float
#  longitude  :float
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  is_primary :boolean          default(FALSE)
#
# Indexes
#
#  index_addresses_on_user_id  (user_id)
#
