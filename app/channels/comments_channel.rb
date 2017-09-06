class CommentsChannel < ApplicationCable::Channel
  def follow
    stream_from "#{params[:question_id]}_comments"
  end
end
