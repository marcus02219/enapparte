require 'rails_helper'

describe ShowsController do

  describe 'GET index' do
    let!(:shows) { create_list(:show_with_rating, 5) }
    before(:each) { get :index }
    it { expect(response).to be_success }
  end

  context "when user signed in" do
    let(:user) { create :user }
    let(:show) { create(:show, user: user) }
    before(:each) do sign_in user end

    describe 'GET edit' do
      before(:each) { get :edit, id: show.id }
      it { expect(assigns(:show)).to_not be_nil }
      it { expect(response).to be_success }
    end

    describe 'GET payment' do
      before(:each) { get :payment, id: show.id }
      it { expect(assigns(:show)).to_not be_nil }
      it { expect(response).to be_success }
    end
  end
end
