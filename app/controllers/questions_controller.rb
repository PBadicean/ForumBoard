class QuestionsController < ApplicationController

  include PublicShowAndIndex
  include Voted

  before_action :ensure_signup_complete, except: [:show, :index]
  before_action :load_question, only: [:show, :destroy, :update]
  before_action :check_author, only: [:destroy, :update]
  after_action :publish_question, only: :create

  def index
    respond_with @questions = Question.all
  end

  def show
    gon.current_user = current_user if current_user.present?
    respond_with @question
  end

  def new
    respond_with @question = Question.new
  end

  def create
    respond_with @question = current_user.questions.create(question_params)
  end

  def destroy
    respond_with @question.destroy
  end

  def update
    respond_with @question.update(question_params)
  end

  private

  def check_author
    head :forbidden unless current_user.author_of(@question)
  end

  def load_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body, attachments_attributes: [:id, :file, :_destroy])
  end

  def publish_question
    return if @question.errors.any?
    ActionCable.server.broadcast(
      'questions',
      ApplicationController.render(
        partial: 'questions/question',
        locals: { question: @question }
      )
    )
  end
end
