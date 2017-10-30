module SubscriptionsHelper
  def subscription(question)
    question.subscriptions.where(question_id: question.id).first
  end
end
