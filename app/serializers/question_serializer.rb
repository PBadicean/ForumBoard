class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :created_at, :updated_at, :schort_title
  has_many :answers

  def schort_title
    object.title.truncate(10)
  end
end
