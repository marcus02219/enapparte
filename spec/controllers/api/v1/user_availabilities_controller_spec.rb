require 'rails_helper'

describe Api::V1::UserAvailabilitiesController do
  let(:user) { create(:user) }

  describe 'GET #index' do
    let(:other_user) { create(:user) }
    let!(:availability_today) do
      create(:user_availability, user: user, available_at: Time.zone.today)
    end
    let!(:availability_yesterday) do
      create(:user_availability, user: user, available_at: Time.zone.yesterday)
    end
    let!(:other_user_availability) do
      create(:user_availability, user: other_user,
                                 available_at: Time.zone.today)
    end

    context 'unauthorised user' do
      before do
        get :index, format: :json
      end

      it { expect(response).to have_http_status(:unauthorized) }

      it { expect(json['error']).to be_present }
    end

    context 'authorised user' do
      before do
        sign_in user
        get :index, format: :json
      end

      it { expect(response).to have_http_status(:success) }

      it 'returns array of availabilities of current user' do
        result = json.map { |e| e['id'] }

        expect(result)
          .to include(availability_today.id, availability_yesterday.id)
      end

      it 'doesn\'t return availabilities of other users' do
        result = json.map { |e| e['id'] }

        expect(result).not_to include(other_user_availability.id)
      end
    end
  end

  describe 'GET #show' do
    let(:other_user) { create(:user) }
    let!(:availability_today) do
      create(:user_availability, user: user, available_at: Time.zone.today)
    end
    let!(:availability_yesterday) do
      create(:user_availability, user: user, available_at: Time.zone.yesterday)
    end
    let!(:other_user_availability) do
      create(:user_availability, user: other_user,
                                 available_at: Time.zone.today)
    end

    context 'unauthorised user' do
      before do
        get :show, id: availability_today.id, format: :json
      end

      it { expect(response).to have_http_status(:unauthorized) }

      it { expect(json['error']).to be_present }
    end

    context 'other user' do
      it 'returns 404 error' do
        sign_in other_user
        expect { get :show, id: availability_today.id, format: :json }
          .to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'authorised user' do
      before do
        sign_in user
        get :show, id: availability_today.id, format: :json
      end

      it { expect(response).to have_http_status(:success) }

      it 'returns availability' do
        result = json['id']

        expect(result).to eq(availability_today.id)
      end
    end
  end

  describe 'GET #create' do
    context 'unauthorised user' do
      before do
        post :create, format: :json,
                      availability: { available_at: '2016-05-12' }
      end

      it { expect(response).to have_http_status(:unauthorized) }

      it { expect(json['error']).to be_present }
    end

    context 'authorised user' do
      before do
        sign_in user
        get :create, format: :json,
                     availability: { available_at: '2016-05-12' }
      end

      it { expect(response).to have_http_status(:success) }

      it 'creates new availability' do
        result = user.availabilities.size

        expect(result).to eq(1)
      end

      it 'returns new availability' do
        result = json['available_at']

        expect(result).to eq('2016-05-12')
      end
    end
  end

  describe 'GET #destroy' do
    let(:other_user) { create(:user) }
    let!(:availability_today) do
      create(:user_availability, user: user, available_at: Time.zone.today)
    end
    let!(:availability_yesterday) do
      create(:user_availability, user: user, available_at: Time.zone.yesterday)
    end
    let!(:other_user_availability) do
      create(:user_availability, user: other_user,
                                 available_at: Time.zone.today)
    end

    context 'unauthorised user' do
      before do
        delete :destroy, id: availability_today.id, format: :json
      end

      it { expect(response).to have_http_status(:unauthorized) }

      it { expect(json['error']).to be_present }
    end

    context 'other user' do
      it 'returns 404 error' do
        sign_in other_user
        expect { get :destroy, id: availability_today.id, format: :json }
          .to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'authorised user' do
      before do
        sign_in user
        delete :destroy, id: availability_today.id, format: :json
      end

      it { expect(response).to have_http_status(:success) }

      it 'destroys availability' do
        result = UserAvailability.exists?(availability_today.id)

        expect(result).to be false
      end
    end
  end
end
