require 'rails_helper'

describe Api::V1::ShowcasesController do
  let(:user) { create :user }

  describe 'GET #index' do
    context 'unauthorized user' do
      before do
        get :index, format: :json
      end

      it { expect(response).to have_http_status(:unauthorized) }

      it { expect(json['error']).to be_present }
    end

    context 'authorized user' do
      let!(:showcase) { create :showcase, user: user }

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
  end
end
