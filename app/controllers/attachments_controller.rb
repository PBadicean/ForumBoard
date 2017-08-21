class AttachmentsController < ApplicationController

  def destroy
    @attachment = Attachment.find(params[:id])
    @attachable = @attachment.attachable
    return head :forbidden unless current_user.author_of(@attachable)
    @attachment.destroy
  end

end
