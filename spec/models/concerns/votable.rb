require 'rails_helper'

shared_examples_for 'votable' do
  it { should have_many(:votes).dependent(:destroy) }

  describe '#rating' do
    let!(:question)       { create(:question) }
    let!(:liked_count)    { create_list(:vote, 4, votable: question, value: 1,) }
    let!(:disliked_count) { create_list(:vote, 2, votable: question, value: -1) }

    it 'should count the rating of question' do
      expect(question.rating).to eq(2)
    end
  end

  describe '#destroy_vote' do
    let!(:user)     { create(:user) }
    let!(:question) { create(:question) }
    let!(:vote)     { create(:vote, votable: question, user: user) }

    it 'must remove the vote of got user' do
      expect{question.destroy_vote(user)}.to change(question.votes, :count).by(-1)
    end
  end
end
