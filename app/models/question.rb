class Question < ApplicationRecord

  has_many :answers, dependent: :destroy
  has_many :attachments, as: :attachable, inverse_of: :attachable

  belongs_to :user

  validates :title, :body, presence: true

  accepts_nested_attributes_for :attachments, reject_if: :all_blank, allow_destroy: true

  def answers_by_best
    return answers if best_answer.nil?
    answers.order("id=#{best_answer} desc")
  end

end
