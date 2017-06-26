class AnswersController < ApplicationController

  before_action :set_question, only: [:create]

  def answer
    @answer = Answer.find(params[:id])
  end

  def create
    @answer = @question.answers.new(answer_params)
    if @answer.save
      redirect_to @question, status: 302
    else
      redirect_to @question, status: 304
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end

  def set_question
    @question = Question.find(params[:question_id])
  end

end
