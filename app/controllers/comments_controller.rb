class CommentsController < ApplicationController

  before_action :set_commentable
  after_action :publish_comment

  def create
    @comment = @commentable.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      render json: @comment
    else
      render json: @comment.errors.messages, status: :unprocessable_entity
    end
  end

  private

  def publish_comment
    return if @comment.errors.any?
    question_id = @commentable.try(:question_id) || @commentable.id
    ActionCable.server.broadcast(
      "#{question_id}_comments", comment: @comment, author: @comment.user
    )
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_commentable
    klass = [Answer, Question].detect{|c| params["#{c.name.underscore}_id"]}
    @commentable = klass.find(params["#{klass.name.underscore}_id"])
  end

end
