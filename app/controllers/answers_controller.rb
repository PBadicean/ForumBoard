class AnswersController < ApplicationController

  include Voted

  before_action :ensure_signup_complete
  before_action :set_answer, only: [:destroy, :accept, :update]
  before_action :check_author, only: [:destroy, :update]
  after_action :publish_answer, only: :create

  def create
    @question = Question.find(params[:question_id])
    respond_with @answer = @question.answers.create(answer_params.merge(user: current_user))
  end

  def destroy
    respond_with @answer.destroy
  end

  def update
    respond_with @answer.update(answer_params)
  end

  def accept
    @question = @answer.question
    return head :forbidden unless current_user.author_of(@question)
    respond_with @question.update(best_answer: @answer.id)
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
