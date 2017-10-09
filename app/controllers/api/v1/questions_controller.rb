class Api::V1::QuestionsController < Api::V1::BaseController

  load_and_authorize_resource

  def index
    @questions = Question.all
    respond_with @questions
  end

  def show
    respond_with @question
  end
end
