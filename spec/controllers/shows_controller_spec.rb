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
#  starts_at        :time
#  ends_at          :time
#  active           :boolean
#  user_id          :integer
#  art_id           :integer
#  language_id      :integer
#  bookings_id      :integer
#  pictures_id      :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  cover_picture_id :integer
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
      let(:show) { create(:show) }
      before(:each) { get :photos, id: show.id }
      it { expect(assigns(:show)).to_not be_nil }
      it { expect(response).to be_success }
    end

    describe 'GET pictures_count' do
      let(:show) { create(:show) }

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
      let(:show) { create(:show) }
      before(:each) { get :cover_picture, id: show.id }
      it { expect(assigns(:show)).to_not be_nil }
      it { expect(response).to be_success }
    end

    describe 'GET shedules' do
      let(:show) { create(:show) }
      before(:each) { get :shedules, id: show.id }
      it { expect(assigns(:show)).to_not be_nil }
      it { expect(response).to be_success }
    end

    describe 'PUT update' do
      let(:show) { create(:show) }

      context "cover_picture" do
        let(:picture) { create :picture }
        before(:each) { put :update, id: show.id, show: { cover_picture_id: picture.id }, format: :json }
        it { expect(assigns(:show).cover_picture).to_not be_nil }
        it { expect(response).to be_success }
      end
    end
  end
end
