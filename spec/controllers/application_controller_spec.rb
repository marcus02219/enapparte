require 'rails_helper'

describe ApplicationController do

  controller do
    def index
      render json: flash
    end
  end

  describe '#set_flash' do
    context do
      let(:flash_message) { Faker::Lorem.sentence }
      before(:each) { get :index, flash: { error: flash_message } }
      it { expect(response.body).to include(flash_message) }
    end

    context 'when msg > 255' do
      let(:flash_message) { Faker::Lorem.sentence * 100 }
      before(:each) { get :index, flash: { error: flash_message } }
      it { expect(response.body).to_not include(flash_message) }
      it { expect(response.body).to include(flash_message[0..255]) }
    end
  end

end
