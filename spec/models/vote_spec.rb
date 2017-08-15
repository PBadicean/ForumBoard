require 'rails_helper'

RSpec.describe Vote do
  it { should belong_to(:votable) }
  it { should belong_to(:user) }

  describe '#liked_count' do
    let!(:question) { create(:question) }
    let!(:votes)    { create_list(:vote, 3, votable: question, value: 1) }

    it 'must return number of liked' do
      expect(question.votes.liked_count).to eq 3
    end
  end

  describe '#disliked_count' do
    let!(:question2) { create(:question) }
    let!(:votes)    { create_list(:vote, 3, votable: question2, value: -1) }

    it 'must return number of disliked' do
      expect(question2.votes.disliked_count).to eq 3
    end
  end
end
