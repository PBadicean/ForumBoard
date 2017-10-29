class Answer < ApplicationRecord

  include Votable
  include Attachable
  include Commentable

  belongs_to :question
  belongs_to :user

  validates :body, presence: true
  after_create :notify_author, :notify_subscribers

  def best?
    id == question.best_answer
  end

  def notify_author
    NotifyDigestJob.perform_later(self)
  end

  def notify_subscribers
    SubscribeDigestJob.perform_later(self)
  end

end
