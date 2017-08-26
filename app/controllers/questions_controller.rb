class QuestionsController < ApplicationController

  include PublicShowAndIndex
  include Voted

  before_action :load_question, only: [:show, :destroy, :update]
  before_action :check_author, only: [:destroy, :update]
  after_action :publish_question, only: [:create]
  after_action :publish_not_question, only: [:destroy]

  def index
    @questions = Question.all
  end

  def show
    @answer = @question.answers.new
  end

  def new
    @question = Question.new
  end

  def create
    @question = current_user.questions.new(question_params)
    if @question.save
      redirect_to @question, notice: 'Ваш вопрос успешно создан'
    else
      render :new
    end
  end

  def destroy
    @question.destroy
    redirect_to questions_path, notice: 'Ваш вопрос успешно удален'
  end

  def update
    @question.update(question_params)
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

  def publish_not_question
    ActionCable.server.broadcast(
      'questions',
      ApplicationController.render(
        partial: 'questions/question',
        locals: { question: @question }
      )
    )
  end

end
