require 'rails_helper'

describe Api::V1::PicturesController do

  context 'when signed in' do
    let(:user) { create :user }
    before(:each) { sign_in user }

    context 'GET index' do
      context 'when user is owner' do
        let(:show) { create :show, user: user }
        let!(:pictures) { create_list :picture, 2, imageable_type: 'Show', imageable_id: show.id }
        let!(:pictures_free) { create_list :picture, 2 }
        before(:each) { get :index, imageable_type: 'Show', imageable_id: show.id, format: :json }
        it { expect(assigns(:pictures).count).to eq 2 }
      end

      context 'when user is not owner' do
        let(:show) { create :show }
        let!(:pictures) { create_list :picture, 2, imageable_type: 'Show', imageable_id: show.id }
        let!(:pictures_free) { create_list :picture, 2 }
        it 'raises exception' do
          expect {
            get :index, imageable_type: 'Show', imageable_id: show.id, format: :json
          }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end

    context 'DELETE destroy' do

      context 'when user is owner' do
        let(:show) { create :show, user: user }
        let(:picture) { create :picture, imageable: show }
        before(:each) { delete :destroy, id: picture.id, format: :json }
        it { expect(Picture.exists?(picture.id)).to eq false }
      end

      context 'when user is not owner' do
        let(:picture) { create :picture }
        it 'raises exception' do
          expect {
            delete :destroy, id: picture.id, format: :json
          }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end
  end
end
