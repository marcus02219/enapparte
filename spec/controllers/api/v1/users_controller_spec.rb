require 'rails_helper'

describe Api::V1::UsersController do
  context 'when didn\'t sign in' do
    before(:each) do
      get :show, id: 1, format: :json
    end

    it { expect(response).to have_http_status(:unauthorized) }
  end

  context 'when signed in' do
    describe 'GET #show' do
      let(:user) { create(:user) }

      before(:each) do
        sign_in user
        get :show, id: user.id, format: :json
      end

      it { expect(response).to be_success }
    end

    describe 'PUT #update' do
      context 'update user with languages params' do
        let(:user) { create(:user) }
        5.times do
          let(:languages) { create(:language) }
        end
        let(:attr) do
          { language_ids: Language.all.map(&:id) }
        end

        before(:each) do
          sign_in user
          put :update, id: user.id, user: attr, format: :json
          user.reload
        end

        it { expect(response).to be_success }
        it { expect(user.language_ids).to eq(Language.all.map(&:id)) }
      end

      context 'update user with showcase' do
        let(:user) { create(:user) }
        let(:attr) do
          {
            showcases_attributes: [{ url: 'http://ya.ru', kind: 'link' },
                                   { url: 'http://goog.le', kind: 'link' }]
          }
        end

        before(:each) do
          sign_in user
          put :update, id: user.id, user: attr, format: :json
          user.reload
        end

        it { expect(response).to be_success }
        it do
          result = user.showcases.map(&:url)

          expect(result).to contain_exactly('http://ya.ru', 'http://goog.le')
        end
      end
    end
  end
end
