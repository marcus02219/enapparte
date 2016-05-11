require 'rails_helper'

describe UsersController do
  let(:user) { create(:user) }

  before(:each) { sign_in user }

  context 'POST upload_photo' do
    before(:each) do
      photo = fixture_file_upload 'missing.png', 'image/png'
      post :upload_photo, image: photo
      user.picture.reload
    end

    it { expect(response).to be_success }
    it { expect(user.picture.image).to be_exists }
    it { expect(response.body).to include(user.picture.image.url(:medium)) }
  end
end
