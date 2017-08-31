class Answer < ApplicationRecord

  include Votable
  include Attachable
  include Commentable

  belongs_to :question
  belongs_to :user

  validates :body, presence: true

  def best?
    id == question.best_answer
  end

end
