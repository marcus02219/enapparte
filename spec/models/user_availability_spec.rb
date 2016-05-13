require 'rails_helper'

describe UserAvailability, type: :model do
  let(:user) { create(:user) }
  subject { build(:user_availability, user: user) }

  describe 'validations' do
    it 'is valid' do
      expect(subject).to be_valid
    end

    it 'not valid without user' do
      subject.user = nil
      expect(subject).not_to be_valid
    end

    it 'not valid without date' do
      subject.available_at = nil
      expect(subject).not_to be_valid
    end
  end
end
