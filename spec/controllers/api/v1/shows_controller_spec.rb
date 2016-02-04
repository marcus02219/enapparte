require 'rails_helper'

describe Api::V1::ShowsController do

  context "when didn't sign in" do
    context "POST create" do
      let(:show_attributes) { attributes_for :show }
      before(:each) { post :create, show: show_attributes }
      it { expect(response.status).to eq 302 }
    end
  end

  context "when signed in" do
    let(:user) { create :user }
    before(:each) { sign_in user }

    context "POST create" do
      let(:show_attributes) { attributes_for :show, art_id: Art.first.id, language_id: Language.first.id }
      before(:each) { post :create, show: show_attributes, format: :json }
      it { expect(response).to be_success }
      it { expect(assigns(:show)).to be_persisted }
      it { expect(assigns(:show).user.id).to eq user.id }
    end

    context "POST create" do
      context 'when user is own' do
        let(:show) { create :show, user: user }
        let(:show_attributes) { attributes_for :show, art_id: Art.first.id, language_id: Language.first.id }
        before(:each) { put :update, id: show.id, show: show_attributes, format: :json }
        it { expect(response).to be_success }
        it { expect(assigns(:show)).to be_persisted }
        it { expect(assigns(:show).user.id).to eq user.id }
      end

      context 'when user is not own' do
        let(:show) { create :show }
        let(:show_attributes) { attributes_for :show, art_id: Art.first.id, language_id: Language.first.id }
        it "raises exception" do
          expect {
            put :update, id: show.id, show: show_attributes, format: :json
          }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end
  end

end
