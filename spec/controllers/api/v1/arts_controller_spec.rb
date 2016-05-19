require 'rails_helper'

describe Api::V1::ArtsController do

  let(:user) { create :user }
  before(:each) { sign_in user }

  context 'GET index' do
    let(:arts) { create_list :art, 2, user: user }
    context 'when get all arts' do
      before(:each) { get :index, format: :json }
      it { expect(assigns(:arts)).to match_array(Art.all) }
    end
  end

end
