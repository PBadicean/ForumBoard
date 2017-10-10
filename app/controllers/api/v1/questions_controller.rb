class Api::V1::QuestionsController < Api::V1::BaseController

  load_and_authorize_resource

  def index
    @questions = Question.all
    respond_with @questions
  end

  def show
    respond_with @question
  end

  def create
    @question = Question.create(question_params.merge(user: current_resource_owner))
    respond_with @question
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
