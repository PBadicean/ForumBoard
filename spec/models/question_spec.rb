require 'rails_helper'
require_relative 'concerns/attachable'
require_relative 'concerns/votable'

RSpec.describe Question, type: :model do
  it { should have_many(:answers) }
  it { should belong_to(:user) }

  it { should validate_presence_of :title }
  it { should validate_presence_of :body }

  it_behaves_like 'attachable'
  it_behaves_like 'votable'

  describe '#answers_by_best'do
    let(:answers) { create_list(:answer, 2) }
    let(:question) { create(:question, answers: answers, best_answer: answers.last.id) }

    it 'must return array where first element is best_answer' do
      expect(question.answers_by_best.first).to eq answers.last
    end
  end
end
