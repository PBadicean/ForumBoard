require "application_responder"

class ApplicationController < ActionController::Base

  def ensure_signup_complete
    return if action_name == 'finish_signup'

    if current_user && !current_user.email_verified?
      redirect_to finish_signup_path(current_user)
    end
  end

  self.responder = ApplicationResponder
  respond_to :js, :html, :json

  protect_from_forgery with: :exception

  before_action :authenticate_user!
end
