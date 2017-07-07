class AnswersController < ApplicationController

  before_action :authenticate_user!, only: [ :create ]
  before_action :set_question, only: [:create]
  before_action :set_answer, only: [:destroy]

  def create
    @answer = @question.answers.create(answer_params.merge(user: current_user))
  end

  def destroy
    @question = @answer.question

    if current_user.author_of(@answer)
      @answer.destroy
      redirect_to @question, notice: 'Ваш ответ успешно удален'
    else
      render 'questions/show'
    end
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
