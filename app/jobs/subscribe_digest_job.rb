class SubscribeDigestJob < ApplicationJob
  queue_as :default

  def perform(answer)
    answer.question.subscriptions.each do |subscription|
      AnswerMailer.new_answer(answer, subscription.user).deliver_later
    end
  end
end
