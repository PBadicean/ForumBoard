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

  describe '#notify_author' do
    let(:answer) { build(:answer) }

    it 'call notify_author after creating' do
      expect(answer).to receive(:notify_author).and_call_original
      answer.save!
    end

    it 'calls NotifyDigestJob' do
      expect(NotifyDigestJob).to receive(:perform_later).with(answer).and_call_original
      answer.save!
    end
  end

  describe '#notify_subscribers' do
    let(:answer) { build(:answer) }

    it 'call notify_subscribers after creating' do
      expect(answer).to receive(:notify_subscribers).and_call_original
      answer.save!
    end

    it 'calls SubscribeDigestJob' do
      expect(SubscribeDigestJob).to receive(:perform_later).with(answer).and_call_original
      answer.save!
    end
  end
end
