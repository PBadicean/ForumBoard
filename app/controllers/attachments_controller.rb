class AttachmentsController < ApplicationController

  load_and_authorize_resource

  def destroy
    respond_with @attachment.destroy
  end

end
