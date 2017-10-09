class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :best_answer, :created_at, :updated_at, :schort_title
  has_many :answers, :attachments

  def schort_title
    object.title.truncate(10)
  end
end
