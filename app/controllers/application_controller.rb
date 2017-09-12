require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :js, :html, :json

  protect_from_forgery with: :exception

  before_action :authenticate_user!
end
