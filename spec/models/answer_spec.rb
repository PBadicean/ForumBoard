require 'rails_helper'
require_relative 'concerns/attachable'
require_relative 'concerns/votable'
require_relative 'concerns/commentable'

RSpec.describe Answer, type: :model do

  it { should belong_to(:question) }
  it { should belong_to(:user) }
  it { should validate_presence_of :body }

  it_behaves_like 'attachable'
  it_behaves_like 'votable'
  it_behaves_like 'commentable'

  describe '#notify' do
    let(:answer) { build(:answer) }

    it 'call notify after creating' do
      expect(answer).to receive(:notify).and_call_original
      answer.save!
    end

    it 'calls NotifyUserJob' do
      expect(NotifyUserJob).to receive(:perform_later).with(answer).and_call_original
      answer.save!
    end

    it 'call notify after creating' do
      expect(answer).to receive(:notify).and_call_original
      answer.save!
    end

    it 'calls NotifyUserJob' do
      expect(NotifyUserJob).to receive(:perform_later).with(answer).and_call_original
      answer.save!
    end
  end
end
