require 'rails_helper'

describe ApplicationController do

  controller do
    def index
      render json: flash
    end
  end

  describe '#set_flash' do
    let(:flash_message) { Faker::Lorem.sentence }
    before(:each) { get :index, flash: { error: flash_message } }
    it { expect(response.body).to include(flash_message) }
  end

end
