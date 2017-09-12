class CommentsController < ApplicationController

  before_action :set_commentable
  after_action :publish_comment

  respond_to :json, only: :create

  def create
    @comment = @commentable.comments.create(comment_params.merge(user: current_user))
    respond_with @comment, json: @comment
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
