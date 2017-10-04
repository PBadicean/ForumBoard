require 'rails_helper'

describe Ability do
  subject(:ability) { Ability.new(user) }

  describe 'for guest' do
    let(:user) { nil }

    it { should be_able_to :read, Question }
    it { should be_able_to :read, Answer }
    it { should be_able_to :read, Comment }

    it { should_not be_able_to :manage, :all }
  end

  describe 'for admin' do
    let(:user) { create :user, admin: true }

    it { should be_able_to :manage, :all }
  end

  describe 'for user' do
    let(:user)     { create :user }
    let(:other)    { create :user }

    let(:best_answer)       { create :answer }
    let(:question_with_best){ create :question, best_answer: best_answer.id }
    let(:answer_own_user)   { create :answer, question: (create :question, user: user) }
    let(:answer_other_user) { create :answer, question: (create :question, user: other) }
    let(:vote_question)     { create(:vote, votable: create(:question, user: other), user: user) }
    let(:vote_answer)       { create(:vote, votable: create(:answer, user: other), user: user) }

    let(:attachment_own_user)   { create :attachment, attachable: (create :question, user: user) }
    let(:attachment_other_user) { create :attachment, attachable: (create :question, user: other) }

    it { should_not be_able_to :manage, :all }
    it { should be_able_to :read, :all }

    it { should be_able_to :create, Question }
    it { should be_able_to :create, Answer }
    it { should be_able_to :create, Comment }

    it { should be_able_to :update, (create :question, user: user), user: user }
    it { should_not be_able_to :update, (create :question, user: other), user: user }

    it { should be_able_to :update, (create :answer, user: user), user: user }
    it { should_not be_able_to :update, (create :answer, user: other), user: user }

    it { should be_able_to :destroy, (create :question, user: user), user: user }
    it { should_not be_able_to :destroy, (create :question, user: other), user: user }

    it { should be_able_to :destroy, (create :answer, user: user), user: user }
    it { should_not be_able_to :destroy, (create :answer, user: other), user: user }

    it { should be_able_to :up_vote, (create :question, user: other), user: user }
    it { should_not be_able_to :up_vote, (create :question, user: user), user: user }

    it { should be_able_to :down_vote, (create :question, user: other), user: user }
    it { should_not be_able_to :down_vote, (create :question, user: user), user: user }

    it { should be_able_to :revote, vote_question.votable, user: user }
    it { should_not be_able_to :revote, (create :question, user: other), user: user }

    it { should be_able_to :up_vote, (create :answer, user: other), user: user }
    it { should_not be_able_to :up_vote, (create :answer, user: user), user: user }

    it { should be_able_to :down_vote, (create :answer, user: other), user: user }
    it { should_not be_able_to :down_vote, (create :answer, user: user), user: user }

    it { should be_able_to :revote, vote_answer.votable, user: user }
    it { should_not be_able_to :revote, (create :answer, user: other), user: user }

    it { should be_able_to :accept, answer_own_user, user: user }
    it { should_not be_able_to :accept, answer_other_user, user: user }
    it { should_not be_able_to :accept, best_answer, user: user }

    it { should be_able_to :destroy, attachment_own_user, user: user }
    it { should_not be_able_to :destroy, attachment_other_user, user: user }
  end
end
