require "application_responder"

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  check_authorization unless :devise_controller?

  self.responder = ApplicationResponder
  respond_to :js, :html, :json

  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  def ensure_signup_complete
    return if action_name == 'finish_signup'

    if current_user && !current_user.email_verified?
      redirect_to finish_signup_path(current_user)
    end
  end
end
