require 'rails_helper'

describe Api::V1::ShowsController do

  context "when didn't sign in" do
    context "POST create" do
      let(:show_attributes) { attributes_for :show }
      before(:each) { post :create, show: show_attributes }
      it { expect(response.status).to eq 302 }
    end
  end

  context "when signed in" do
    let(:user) { create :user }
    before(:each) { sign_in user }

    context "POST create" do
      let(:show_attributes) { attributes_for :show, art_id: Art.first.id, language_id: Language.first.id }
      before(:each) { post :create, show: show_attributes, format: :json }
      it { expect(response).to be_success }
      it { expect(assigns(:show)).to be_persisted }
      it { expect(assigns(:show).user.id).to eq user.id }
    end

    context "PUT update" do
      context 'when user is owner' do
        let(:show) { create :show, user: user }
        let(:show_attributes) { attributes_for :show, art_id: Art.first.id, language_id: Language.first.id }
        before(:each) { put :update, id: show.id, show: show_attributes, format: :json }
        it { expect(response).to be_success }
        it { expect(assigns(:show)).to be_persisted }
        it { expect(assigns(:show).user.id).to eq user.id }
      end

      context 'when user is not owner' do
        let(:show) { create :show }
        let(:show_attributes) { attributes_for :show, art_id: Art.first.id, language_id: Language.first.id }
        it "raises exception" do
          expect {
            put :update, id: show.id, show: show_attributes, format: :json
          }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end

    context "GET index" do
      context 'for current user' do
        let!(:shows) { create_list(:show, 2, user: user) }
        before(:each) { get :index, format: :json }
        it { expect(assigns(:shows).map(&:id)).to match_array(shows.map(&:id)) }
      end

      after(:each) { expect(response).to be_success }
    end

    context "DELETE destroy" do
      context 'when user is owner' do
        let(:show) { create :show, user: user }
        before(:each) { delete :destroy, id: show.id, format: :json }
        it { expect(response).to be_success }
        it { expect(Show.exists?(show.id)).to eq false }
      end

      context 'when user is not owner' do
        let(:show) { create :show }
        let(:show_attributes) { attributes_for :show, art_id: Art.first.id, language_id: Language.first.id }
        it "raises exception" do
          expect {
            delete :destroy, id: show.id, format: :json
          }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end

    context 'POST toggle_active' do
      context 'with valid fields' do
        let(:show) { create :show, user: user }
        before(:each) { post :toggle_active, id: show.id, format: :json }
        it { expect(assigns(:show)).to be_active }
        it { expect(response).to be_success }
      end

      context 'when email didn\'t confirm' do
        let!(:show) { create :show, user: user }
        before(:each) { user.update(confirmed_at: nil) }
        before(:each) { post :toggle_active, id: show.id, format: :json }
        it { expect(response.status).to eq 401 }
      end

      context 'when address is empty' do
        let!(:show) { create :show, user: user }
        before(:each) { user.addresses.destroy_all }
        before(:each) { post :toggle_active, id: show.id, format: :json }
        it { expect(response.status).to eq 422 }
        it { expect(assigns(:show)).to_not be_active }
        it { expect(response.body).to include(I18n.t('activerecord.errors.messages.addresses_is_empty')) }
      end

      context 'when phone number is empty' do
        let!(:show) { create :show, user: user }
        before(:each) { user.update(phone_number: nil) }
        before(:each) { post :toggle_active, id: show.id, format: :json }
        it { expect(response.status).to eq 422 }
        it { expect(assigns(:show)).to_not be_active }
        it { expect(response.body).to include(I18n.t('activerecord.errors.messages.phone_number_is_empty')) }
      end
    end

    context 'GET arts' do
      let!(:arts) { create_list :art, 3 }
      let!(:show) { create :show, user: user, art: Art.first, active: true }
      let!(:show2) { create :show, user: user, art: Art.last, active: true }
      let!(:show3) { create :show, user: user, art_id: 1234, active: true }
      before(:each) { get :arts, format: :json }
      it { expect(assigns(:arts)).to match_array([Art.first, Art.last]) }
    end

    context "GET search" do
      let!(:shows) { create_list(:show_with_rating, 5, user: user, active: true) }
      let!(:shows_not_active) { create_list(:show, 2, user: user, active: false) }

      context 'when without params' do
        before(:each) { get :search, format: :json }
        it { expect(assigns(:shows).map(&:id)).to eq (shows.sort {|a,b| b.rating <=> a.rating }.map(&:id)) }
      end

      context 'when full text search' do
        let!(:show) { create(:show_with_rating, user: user, active: true, title: 'Ruby') }
        before(:each) { get :search, q: show.title, format: :json }
        it { expect(assigns(:shows).size).to eq 1 }
      end

      after(:each) { expect(response).to be_success }
    end

  end

end
