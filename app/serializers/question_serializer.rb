class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :best_answer, :created_at, :updated_at, :schort_title, :user_id
  has_many :answers, :attachments, :comments

  def schort_title
    object.title.truncate(10)
  end
end
