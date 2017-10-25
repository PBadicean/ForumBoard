require "rails_helper"

RSpec.describe AnswerMailer, type: :mailer do
  let(:user)   { create(:user) }
  let(:answer)   { create(:answer) }
  let(:mail) { AnswerMailer.new_answer(answer, user) }

  it 'renders the body' do
    expect(mail.body.encoded).to match answer.body
  end
end
