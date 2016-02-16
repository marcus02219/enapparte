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

describe ShowsController do

  context 'when user didn\'t sign in'  do
    let(:show_attributes) { attributes_for :show }
    before(:each) { post :index, show: show_attributes }
    it { expect(response).to redirect_to(new_user_session_path) }
  end

  context "when user signed in" do

    let(:user) { create :user }
    let(:show) { create(:show, user: user) }
    before(:each) do sign_in user end

    describe 'GET edit' do
      before(:each) { get :edit, id: show.id }
      it { expect(assigns(:show)).to_not be_nil }
      it { expect(response).to be_success }
    end

    describe 'GET index' do
      let!(:shows) { create_list(:show_with_rating, 3) }
      before(:each) { get :index }
      it { expect(response).to be_success }
      it { expect(assigns(:shows)).to_not be_empty }
      it { expect(assigns(:shows).map(&:id)).to eq shows }
    end
  end
end
