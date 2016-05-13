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
  end
end
