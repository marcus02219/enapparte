require 'rails_helper'

describe ShowsController do
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

  describe 'POST photo_upload' do
    let(:show) { create(:show) }
    it 'creates Photo' do
      expect {
        post :photo_upload, id: show.id, picture: fixture_file_upload('missing.png', 'image/png'), format: :json
        show.reload
      }.to change { show.pictures.count }.by(1)
    end
    it 'returns image preview' do
      post :photo_upload, id: show.id, file_data: fixture_file_upload('missing.png', 'image/png'), format: :json
      expect(response.body).to include("img src='#{show.pictures.first.image.url(:medium)}'")
    end
  end
end
