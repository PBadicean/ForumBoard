require 'rails_helper'

RSpec.describe NotifyUserJob, type: :job do

  let(:author)     { create(:user) }
  let(:question) { create(:question, user: author) }
  let(:answer)   { create(:answer, question: question) }

  let(:user)           { create(:user) }
  let(:other_question) {create(:question) }
  let(:subscriptions)  { create_list(:subscription, question: other_question, user: user) }
  let(:other_answer)   { create(:answer, user: user) }


  it 'sends daily digest for author the question' do
    expect(AnswerMailer).to receive(:new_answer).with(answer, author).and_call_original
    NotifyUserJob.perform_now(answer)
  end

  it 'sends daily digest for subscribers the question ' do
    other_question.subscriptions.each do |subscription|
      expect(AnswerMailer).to receive(:new_answer).with(
        other_answer, subscription.user).and_call_original
    end
    NotifyUserJob.perform_now(other_answer)
  end
end
