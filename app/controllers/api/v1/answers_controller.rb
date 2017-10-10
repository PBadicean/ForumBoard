class Api::V1::AnswersController < Api::V1::BaseController

  load_and_authorize_resource

  def show
    respond_with @answer
  end
end
