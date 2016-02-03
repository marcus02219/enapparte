require 'rails_helper'

describe Api::V1::PicturesController do

  context 'when signed in' do
    let(:user) { create :user }
    before(:each) { sign_in user }

    context 'GET index' do
      let(:show) { create :show }
      let!(:pictures) { create_list :picture, 2, imageable_type: 'Show', imageable_id: show.id }
      let!(:pictures_free) { create_list :picture, 2 }
      before(:each) { get :index, imageable_type: 'Show', imageable_id: show.id, format: :json }
      it { expect(assigns(:pictures).count).to eq 2 }
    end
  end

end
