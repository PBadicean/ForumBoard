class AnswerMailer < ApplicationMailer
  def new_answer(answer, user)
    @answer = answer
    @user = user
    mail to: @user.email
  end
end
