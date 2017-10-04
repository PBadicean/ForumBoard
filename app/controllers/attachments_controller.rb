class AttachmentsController < ApplicationController

  before_action :ensure_signup_complete
  authorize_resource

  def destroy
    @attachment = Attachment.find(params[:id])
    @attachable = @attachment.attachable
    respond_with @attachment.destroy
  end

end
