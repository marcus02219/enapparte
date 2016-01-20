require 'rails_helper'

describe Api::V1::UsersController do

  context "when didn't sign in" do
    it { get :show, id: 1, format: :json }

    after(:each) do
      expect(response.status).to eq 401
    end
  end

  context "when signed in" do
    context "GET show" do
      let(:user) { create(:user) }

      before(:each) do
        sign_in user
        get :show, id: user.id, format: :json
      end

      it { expect(response).to be_success }
    end
  end

end
