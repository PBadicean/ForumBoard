class NotifyDigestJob < ApplicationJob
  queue_as :default

  def perform(answer)
    AnswerMailer.new_answer(answer, answer.user).deliver_later
  end
end
