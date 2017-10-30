class Answer < ApplicationRecord

  include Votable
  include Attachable
  include Commentable

  belongs_to :question
  belongs_to :user

  validates :body, presence: true
  after_create :notify

  def best?
    id == question.best_answer
  end

  def notify
    NotifyUserJob.perform_later(self)
  end

end
