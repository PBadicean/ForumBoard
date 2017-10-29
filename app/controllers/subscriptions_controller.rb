class SubscriptionsController < ApplicationController
  load_resource

  def create
    @question = Question.find(params[:question_id])
    authorize! :subscribe, @question
    @subscription = @question.subscriptions.create(user: current_user)
    respond_with @subscription
  end


  def destroy
    @question = Question.find(params[:question_id])
    
    authorize! :unsubscribe, @question
    respond_with @subscription.destroy
  end
end
