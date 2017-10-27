require 'rails_helper'
require_relative 'concerns/attachable'
require_relative 'concerns/votable'
require_relative 'concerns/commentable'

RSpec.describe Question, type: :model do
  it { should have_many(:answers).dependent(:destroy) }
  it { should have_many(:subscriptions).dependent(:destroy) }

  it { should belong_to(:user) }

  it { should validate_presence_of :title }
  it { should validate_presence_of :body }

  it_behaves_like 'attachable'
  it_behaves_like 'votable'
  it_behaves_like 'commentable'

  describe '#answers_by_best'do
    let(:answers) { create_list(:answer, 2) }
    let(:question) { create(:question, answers: answers, best_answer: answers.last.id) }

    it 'must return array where first element is best_answer' do
      expect(question.answers_by_best.first).to eq answers.last
    end
  end

  describe '#questions_today' do
    let(:question_today) { create(:question) }
    let(:question_long)  { create(:question, created_at: Time.now - 3.days) }

    it 'musts return all more new question' do
      expect(Question.questions_today).to include(question_today)
    end

    it 'not returns all more new question' do
      expect(Question.questions_today).to_not include(question_long)
    end
  end
end
