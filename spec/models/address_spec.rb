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

require 'rails_helper'

RSpec.describe Address, type: :model do

  context '#set_is_primary' do
    let(:user) { create(:user) }
    it { expect(user.addresses.first.is_primary).to be true }

    context 'added second address' do
      before(:each) do
        user.reload
        @address2 = create :address, user: user
      end
      it { expect(@address2.is_primary).to be false }
    end
  end

end
