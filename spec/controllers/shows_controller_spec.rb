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
    before(:each) { post :create, show: show_attributes }
    it { expect(response).to redirect_to(new_user_session_path) }
  end

  context "when user signed in" do

    let(:user) { create :user }
    let(:show) { create(:show, user: user) }
    before(:each) do sign_in user end

    describe 'POST create' do
      let(:show_attributes) { attributes_for :show }
      it 'creates Show' do
        expect {
          post :create, show: show_attributes
        }.to change { Show.count }.by(1)
      end
      it 'redirects to action photos' do
        post :create, show: show_attributes
        show = Show.last
        expect(response).to redirect_to(action: :photos, id: show.id)
      end
    end

    describe 'GET photos' do
      before(:each) { get :photos, id: show.id }
      it { expect(assigns(:show)).to_not be_nil }
      it { expect(response).to be_success }
    end

    describe 'GET pictures_count' do
      context "pictures count == 0" do
        before(:each) { get :pictures_count, id: show.id }
        it { expect(response.body).to eq "0" }
      end

      context "pictures count > 0" do
        let(:pictures_count) { 3 }
        before(:each) { pictures_count.times.each { show.pictures.create } }
        before(:each) { get :pictures_count, id: show.id }
        it { expect(response.body).to eq pictures_count.to_s }
      end
    end

    describe 'GET cover_picture' do
      before(:each) { get :cover_picture, id: show.id }
      it { expect(assigns(:show)).to_not be_nil }
      it { expect(response).to be_success }
    end

    describe 'GET shedules' do
      before(:each) { get :shedules, id: show.id }
      it { expect(assigns(:show)).to_not be_nil }
      it { expect(response).to be_success }
    end

    describe 'PUT update' do
      context "cover_picture" do
        let(:picture) { create :picture }
        before(:each) { put :update, id: show.id, show: { cover_picture_id: picture.id }, format: :json }
        it { expect(assigns(:show).cover_picture).to_not be_nil }
        it { expect(response).to be_success }
      end

      context "shedules" do
        let(:starts_at) { '00:00' }
        let(:ends_at) { '02:00' }
        before(:each) { put :update, id: show.id, show: { starts_at: starts_at, ends_at: ends_at } }
        it { expect(assigns(:show).starts_at).to eq starts_at }
        it { expect(assigns(:show).ends_at).to eq ends_at }
        it { expect(response).to redirect_to(shows_dashboard_path) }
      end
    end

    after(:each) do
      expect(assigns(:show).user.try(:id)).to eq user.id
    end
  end
end
