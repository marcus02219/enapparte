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
      it { expect(assigns(:user)).to_not be_nil }
    end

    context 'GET messages' do
      before(:each) do
        get :messages
      end

      it { expect(response).to be_success }
      it { expect(assigns(:user)).to_not be_nil }
    end

    context 'GET shows' do
      before(:each) do
        get :shows
      end

      it { expect(response).to be_success }
      it { expect(assigns(:user)).to_not be_nil }
    end

    context 'GET performances' do
      before(:each) do
        get :performances
      end

      it { expect(response).to be_success }
      it { expect(assigns(:user)).to_not be_nil }
    end

    context 'GET account' do
      before(:each) do
        get :account
      end

      it { expect(response).to be_success }
      it { expect(assigns(:user)).to_not be_nil }
    end

    context 'GET bookings' do
      before(:each) do
        get :bookings
      end

      it { expect(response).to be_success }
      it { expect(assigns(:user)).to_not be_nil }
    end

  end

end
