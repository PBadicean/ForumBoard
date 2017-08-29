class AnswersChannel < ApplicationCable::Channel
  def follow
    stream_from "#{params[:question_id]}_answers"
  end
end
