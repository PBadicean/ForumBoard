class Question < ApplicationRecord

  include Votable
  include Commentable
  include Attachable

  has_many :answers, dependent: :destroy

  belongs_to :user

  validates :title, :body, presence: true
  scope :questions_today, -> { where('created_at >= ?', 1.days.ago) }

  def answers_by_best
    return answers if best_answer.nil?
    answers.order("id=#{best_answer} desc")
  end

end
