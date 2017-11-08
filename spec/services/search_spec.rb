require 'rails_helper'

RSpec.describe Search, type: :model do
  let(:query)    { 'lalala' }

  %w(Everywhere Question Answer Comment User).each do |division|
    it "contains #{division}" do
      expect(Search::DIVISIONS).to include(division)
    end
  end

  describe '#find_object' do
    context 'when search in some model' do
      %w(Question Answer Comment User).each do |division|
        it 'search object in hes model' do
          expect(division.constantize).to receive(:search).with(query).and_call_original
          Search.find_object(query, division)
        end
      end
    end
    context 'when search everywhere' do
      it 'return object find everywhere' do
        expect(ThinkingSphinx).to receive(:search).with(query).and_call_original
        Search.find_object(query, 'Everywhere')
      end
    end
  end
end
