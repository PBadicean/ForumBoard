require "application_responder"

class ApplicationController < ActionController::Base

  self.responder = ApplicationResponder
  respond_to :js, :html, :json
  protect_from_forgery with: :exception
  before_action :ensure_signup_complete, except: :devise_controller?

  before_action :authenticate_user!
  check_authorization unless :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.html { redirect_to root_url, alert: exception.message }
      format.json { render json: exception.message, status: :forbidden }
      format.js   { render json: exception.message, status: :forbidden }
    end
  end

  def ensure_signup_complete
    return if action_name == 'finish_signup'

    if current_user && !current_user.email_verified?
      redirect_to finish_signup_path(current_user)
    end
  end

end
