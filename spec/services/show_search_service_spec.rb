require 'rails_helper'

describe ShowSearchService, type: :service do
  let!(:show_song) do
    create(:show, title: 'First Song', price: 60, active: true)
  end
  let!(:show_bit) do
    create(:show, title: 'Bit Song', price: 80, active: true)
  end
  let!(:show_clip) do
    create(:show, title: 'Clip', price: 100, active: true)
  end

  describe '#results' do
    subject { Show.import; sleep(1); described_class.new(params).results }

    describe 'filter by query' do
      context 'query exists' do
        let(:params) { { query: '*song*' } }
        subject { described_class.new(params).results }

        it 'returns filtered shows' do
          expect(subject).to contain_exactly(show_song, show_bit)
        end
      end
    end

    describe 'filter by price' do
      context 'price range exists' do
        let(:params) { { price_min: 70, price_max: 90 } }

        it 'returns filtered shows' do
          expect(subject).to contain_exactly(show_bit)
        end
      end
    end

    context 'all params empty' do
      let(:params) { { query: '', price_min: '', price_max: '' } }

      it 'returns all shows' do
        expect(subject).to contain_exactly(show_song, show_bit, show_clip)
      end
    end
  end
end
