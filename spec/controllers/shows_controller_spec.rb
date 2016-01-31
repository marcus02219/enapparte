require 'rails_helper'

describe ShowsController do
  describe '#create' do
    it 'creates Show' do
      show_attributes = attributes_for :show
      expect {
        post :create, show: show_attributes
      }.to change { Show.count }.by(1)
    end
  end
end
