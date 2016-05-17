require 'rails_helper'

describe Api::V1::ShowcasesController do
  render_views
  let(:user) { create :user }

  describe 'GET #index' do
    let!(:showcase) { create :showcase, user: user }

    context 'authorized user' do
      before do
        sign_in user
        get :index, format: :json
      end

      it { expect(response).to have_http_status(:success) }

      it 'returns list of showcases' do
        result = json.map { |e| e['id'] }

        expect(result).to contain_exactly(showcase.id)
      end
    end

    context 'unauthorized user' do
      before do
        get :index, format: :json
      end

      it { expect(response).to have_http_status(:unauthorized) }

      it { expect(json['error']).to be_present }
    end
  end

  describe 'GET #show' do
    let!(:showcase) { create :showcase, user: user }

    context 'authorized user' do
      before do
        sign_in user
        get :show, id: showcase.id, format: :json
      end

      it { expect(response).to have_http_status(:success) }

      it 'returns showcase' do
        result = json['id']

        expect(result).to eq(showcase.id)
      end
    end

    context 'unauthorized user' do
      before do
        get :show, id: showcase.id, format: :json
      end

      it { expect(response).to have_http_status(:unauthorized) }

      it { expect(json['error']).to be_present }
    end
  end

  describe 'POST #create' do
    let(:params) { { url: 'http://ya.ru', kind: 'link' } }

    context 'authorized user' do
      before do
        sign_in user
        post :create, showcase: params, format: :json
      end

      it { expect(response).to have_http_status(:success) }

      it 'creates showcase' do
        result = json['url']

        expect(result).to eq('http://ya.ru')
      end
    end

    context 'unauthorized user' do
      before do
        post :create, showcase: params, format: :json
      end

      it { expect(response).to have_http_status(:unauthorized) }

      it { expect(json['error']).to be_present }
    end
  end

  describe 'PATCH #update' do
    let!(:showcase) { create :showcase, user: user }
    let(:params) { { url: 'http://yahoo.com' } }

    context 'authorized user' do
      before do
        sign_in user
        patch :update, id: showcase.id, showcase: params, format: :json
      end

      it { expect(response).to have_http_status(:success) }

      it 'updates showcase' do
        showcase.reload
        result = showcase.url

        expect(result).to eq('http://yahoo.com')
      end
    end

    context 'unauthorized user' do
      before do
        patch :update, id: showcase.id, showcase: params, format: :json
      end

      it { expect(response).to have_http_status(:unauthorized) }

      it { expect(json['error']).to be_present }
    end
  end

  describe 'DELETE #destroy' do
    let!(:showcase) { create :showcase, user: user }

    context 'authorized user' do
      before do
        sign_in user
        delete :destroy, id: showcase.id, format: :json
      end

      it { expect(response).to have_http_status(:success) }

      it 'deletes showcase' do
        result = Showcase.where(id: showcase.id)

        expect(result).to be_empty
      end
    end

    context 'unauthorized user' do
      before do
        delete :destroy, id: showcase.id, format: :json
      end

      it { expect(response).to have_http_status(:unauthorized) }

      it { expect(json['error']).to be_present }
    end
  end
end
