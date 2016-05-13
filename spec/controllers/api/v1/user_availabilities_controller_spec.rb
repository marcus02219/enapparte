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
  end
end
