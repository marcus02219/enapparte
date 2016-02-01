require 'rails_helper'

describe PicturesController do
  describe 'POST create' do
    before(:each) { post :create, file_data: fixture_file_upload('missing.png', 'image/png'), format: :json }
    it { expect(Picture.count).to eq 1 }
    it { expect(Picture.first.image).to be_exists }
    it { expect(response.body).to include("img src='#{Picture.first.image.url(:medium)}'") }
    it { expect(response.body).to include("\"url\":\"#{ picture_path(Picture.first) }") }
  end

  describe 'DELETE destroy' do
    let!(:picture) { create(:picture) }
    before(:each) { delete :destroy, id: picture.id }
    it { expect(Picture.count).to eq 0 }
  end

  describe 'POST destroy' do
    let!(:picture) { create(:picture) }
    before(:each) { post :destroy, id: picture.id }
    it { expect(Picture.count).to eq 0 }
  end
end
