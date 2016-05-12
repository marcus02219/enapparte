require 'rails_helper'

describe CreateAdminService, type: :service do
  describe '#perform' do
    it 'creates a new user' do
      expect { described_class.new.perform }.to change { User.all.size }.by(1)
    end

    it 'new user is admin' do
      described_class.new.perform

      result = User.last

      expect(result).to be_admin
    end
  end
end
