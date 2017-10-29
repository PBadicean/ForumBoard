require 'rails_helper'

RSpec.describe SubscribeDigestJob, type: :job do
  let(:user)           { create (:user) }
  let(:question)     {create(:question) }
  let(:subscriptions) { create_list(:subscription, question: question, user: user) }
  let(:answer)         { create(:answer, user: user) }

  it 'sends daily digest' do
    question.subscriptions.each do |subscription|
      expect(AnswerMailer).to receive(:new_answer).with(
        answer, subscription.user).and_call_original
    end
    NotifyDigestJob.perform_now(answer)
  end
end
