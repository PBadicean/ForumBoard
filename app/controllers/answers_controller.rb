class AnswersController < ApplicationController

  include Voted

  before_action :set_answer, only: [:destroy, :accept, :update]
  before_action :check_author, only: [:destroy, :update]
  after_action :publish_answer, only: [:create]

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.create(answer_params.merge(user: current_user))
  end

  def destroy
    @answer.destroy
  end

  def update
    @answer.update(answer_params)
  end

  def accept
    @question = @answer.question
    if current_user.author_of(@question)
      @question.update(best_answer: @answer.id)
    else
      head :forbidden
    end
  end

  private

  def check_author
    head :forbidden unless current_user.author_of(@answer)
  end

  def answer_params
    params.require(:answer).permit(:body, attachments_attributes: [:id, :file, :_destroy])
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end

  def publish_answer
    return if @answer.errors.any?
    ActionCable.server.broadcast(
      "#{@question.id}_answers",
      answer: @answer, question: @question, attachments: @answer.attachments,
      author: @answer.user, answer_rating: @answer.rating
    )
  end
end
