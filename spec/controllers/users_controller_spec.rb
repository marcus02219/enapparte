require 'rails_helper'

describe 'UsersController' do
  let(:user) { create(:user) }

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in user
  end

  context 'GET dashboard' do
    it 'returns HTTP_OK' do
      get :dashboard
      expect(response.status).to be HTTP_OK
    end
  end

end
