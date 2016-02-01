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
end
