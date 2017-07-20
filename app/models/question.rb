class Question < ApplicationRecord

  has_many :answers, dependent: :destroy
  belongs_to :user

  validates :title, :body, presence: true

  def answers_by_best
    if best_answer.present?
      answers.order("id=#{best_answer} desc")
    else
      answers
    end
  end

end
