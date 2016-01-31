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
    it 'returns success' do
      show = create(:show)
      get :photos, id: show.id
      expect(assigns(:show)).to_not be_nil
      expect(response).to be_success
    end
  end
end
