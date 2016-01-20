require 'rails_helper'

describe DashboardController do

  context 'when didn\'t sign in' do
    context 'GET index' do
      it 'returns HTTP_OK' do
        get :index
        expect(response).to be_redirect
      end
    end
  end

  context 'when signed in' do
    let(:user) { create(:user) }

    before(:each) do
      sign_in user
    end

    context 'GET index' do
      before(:each) do
        get :index
      end

      it { expect(response).to be_success }
    end

    context 'GET profile' do
      before(:each) do
        get :profile
      end

      it { expect(response).to be_success }
    end
  end

end
