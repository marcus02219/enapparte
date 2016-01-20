require 'rails_helper'

describe UsersController do
  let(:user) { create(:user) }

  before(:each) { sign_in user }

  context 'POST upload_photo' do
    before(:each) do
      photo = File.open Rails.root.join('public/images/picture/medium/missing.png')
      post :upload_photo, photo: photo
    end

    it { expect(user.picture.photo.exists?).to be_true }
  end
end
