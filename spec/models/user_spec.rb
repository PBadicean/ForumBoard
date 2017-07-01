require 'rails_helper'

RSpec.describe User do
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }
  it { should have_many :questions }

  describe '#author_of?'do
    let(:user) { create :user }
    let(:question) { create(:question, user: user) }
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
end
