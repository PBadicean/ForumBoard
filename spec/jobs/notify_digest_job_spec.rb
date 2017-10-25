require 'rails_helper'

RSpec.describe NotifyDigestJob, type: :job do
  let(:user) { create (:user) }
  let(:answer) { create(:answer, user: user) }

  it 'sends daily digest' do
    expect(AnswerMailer).to receive(:new_answer).with(answer, user).and_call_original
    NotifyDigestJob.perform_now(answer)
  end
end
