require 'rails_helper'

RSpec.describe AttachmentsController, type: :controller do

  describe 'DELETE #destroy'do
    sign_in_user
    let(:question) { create(:question, user: @user) }
    let(:attachment) { create(:attachment, attachable: question) }

    context 'author tries to delete attachment' do
      it 'assigns attachment to @attachment' do
        delete :destroy, params: { id: attachment, format: :js }
        expect(assigns(:attachment)).to eq attachment
      end

      it 'assigns attachable to @attachable' do
        delete :destroy, params: { id: attachment, format: :js }
        expect(assigns(:attachable)).to eq question
      end

      it 'destroys attachment' do
        attachment
        expect { delete :destroy, params: { id: attachment, format: :js
                                          } }.to change(question.attachments, :count).by(-1)
      end

      it 'render destroy template' do
        delete :destroy, params: { id: attachment, format: :js }
        expect(response).to render_template 'destroy'
      end
    end

    context 'non author tries to delete user attachment' do
      it 'does not destroy attachment' do
        expect { delete :destroy, params: { id: attachment, format: :js
                                          } }.to_not change(question.attachments, :count)
      end
    end
  end
end
