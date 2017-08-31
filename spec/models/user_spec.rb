require 'rails_helper'

RSpec.describe User do
  it { should have_many :questions }
  it { should have_many :answers }
  it { should have_many :votes }
  it { should have_many :comments }


  it { should validate_presence_of :email }
  it { should validate_presence_of :password }

  describe '#author_of?'do
    let(:user)      { create :user }
    let(:question)  { create(:question, user: user) }
    let(:question2) { create(:question) }

    context 'user is author' do
      it 'must return true' do
        expect(user.author_of(question)).to be_truthy
      end
    end

    context 'user is not author' do
      it 'must return false' do
        expect(user.author_of(question2)).to be_falsey
      end
    end
  end

  describe '#was_voting' do
    let(:user)       { create(:user) }
    let(:question)   { create(:question) }
    let(:vote)       { create(:vote, user: user, votable: question) }

    context 'tries to vote one time' do
      it 'must return false' do
        expect(user.was_voting(question)).to eq false
      end
    end

    context 'tries to vote second time' do
      it 'must return true' do
        vote
        expect(user.was_voting(question)).to eq true
      end
    end
  end
end
