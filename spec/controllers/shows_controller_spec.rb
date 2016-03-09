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
#
# Indexes
#
#  index_shows_on_art_id            (art_id)
#  index_shows_on_cover_picture_id  (cover_picture_id)
#  index_shows_on_user_id           (user_id)
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
      let!(:shows) { create_list(:show_with_rating, 5) }
      before(:each) { get :index }
      it { expect(response).to be_success }
    end
  end
end
