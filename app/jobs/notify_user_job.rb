class NotifyUserJob < ApplicationJob
  queue_as :default

  def perform(answer)
    AnswerMailer.new_answer(answer, answer.question.user).deliver_later
    answer.question.subscriptions.each do |subscription|
      AnswerMailer.new_answer(answer, subscription.user).deliver_later
    end
  end
end
