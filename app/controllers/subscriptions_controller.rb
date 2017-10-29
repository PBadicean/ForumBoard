class SubscriptionsController < ApplicationController
  load_resource
  before_action :set_queston

  def create
    authorize! :subscribe, @question
    @subscription = @question.subscriptions.create(user: current_user)
    respond_with @subscription
  end


  def destroy
    authorize! :unsubscribe, @question
    respond_with @subscription.destroy
  end

  def set_queston
    @question = Question.find(params[:question_id])
  end
end
