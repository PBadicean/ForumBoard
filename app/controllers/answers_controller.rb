class AnswersController < ApplicationController

  before_action :authenticate_user!, only: [ :create ]
  before_action :set_question, only: [:create, :destroy, :update, :accept]
  before_action :set_answer, only: [:destroy, :update, :accept]

  def create
    @answer = @question.answers.create(answer_params.merge(user: current_user))
  end

  def destroy
    @answer.destroy if current_user.author_of(@answer)
  end

  def update
    @answer.update(answer_params) if current_user.author_of(@answer)
  end

  def accept
    @question.update(best_answer: @answer.id)
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end
end
