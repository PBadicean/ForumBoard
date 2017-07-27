class Answer < ApplicationRecord

  has_many :attachments, as: :attachmentable

  belongs_to :question
  belongs_to :user

  validates :body, presence: true

  accepts_nested_attributes_for :attachments


  def best?
    id == question.best_answer
  end

end
