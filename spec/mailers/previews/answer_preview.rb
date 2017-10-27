# Preview all emails at http://localhost:3000/rails/mailers/new_answer
class AnswerPreview < ActionMailer::Preview

  def new_answer
    AnswerMailer.new_answer
  end

end
