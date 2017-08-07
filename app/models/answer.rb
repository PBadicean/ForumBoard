class Answer < ApplicationRecord

  has_many :attachments, as: :attachable, inverse_of: :attachable, dependent: :destroy

  belongs_to :question
  belongs_to :user

  validates :body, presence: true

  accepts_nested_attributes_for :attachments, reject_if: :all_blank, allow_destroy: true


  def best?
    id == question.best_answer
  end

end
