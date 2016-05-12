require 'rails_helper'

describe ShowSearchService, type: :service do
  let(:art_video) { create(:art, title: 'Video') }
  let(:art_music) { create(:art, title: 'Music') }
  let!(:show_song) do
    create(:show, title: 'First Song', price: 60, art: art_music, active: true)
  end
  let!(:show_bit) do
    create(:show, title: 'Bit Song', price: 80, art: art_music, active: true)
  end
  let!(:show_clip) do
    create(:show, title: 'Clip', price: 100, art: art_video, active: true)
  end

  describe '#results' do
    subject { described_class.new(params).results }

    describe 'filter by query' do
      context 'query exists' do
        let(:params) { { query: '*song*' } }

        it 'returns filtered shows' do
          expect(subject).to contain_exactly(show_song)
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

    describe 'filter by arts' do
      context 'arts exist' do
        let(:params) { { arts: "[#{art_video.id}]" } }

        it 'returns filtered shows' do
          expect(subject).to contain_exactly(show_clip)
        end
      end
    end

    context 'all params empty' do
      let(:params) { { query: '', price_min: '', price_max: '', arts: '' } }

      it 'returns all shows' do
        expect(subject).to contain_exactly(show_song, show_bit, show_clip)
      end
    end
  end
end
