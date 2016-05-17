require 'rails_helper'

describe Showcase, type: :model do
  let(:user) { create(:user) }
  subject { build(:showcase, user: user) }

  describe 'validations' do
    it 'is valid' do
      expect(subject).to be_valid
    end

    it 'not valid without user' do
      subject.user = nil
      expect(subject).not_to be_valid
    end

    it 'not valid without url' do
      subject.url = nil
      expect(subject).not_to be_valid
    end
  end
end
