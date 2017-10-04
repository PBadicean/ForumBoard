class AnswersController < ApplicationController
  include Voted

  before_action :ensure_signup_complete
  after_action :publish_answer, only: :create
  load_and_authorize_resource except: :accept

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
    @answer = Answer.find(params[:id])
    @question = @answer.question
    authorize! :accept, @answer
    respond_with @question.update(best_answer: @answer.id)
  end

  private

  def answer_params
    params.require(:answer).permit(:body, attachments_attributes: [:id, :file, :_destroy])
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
