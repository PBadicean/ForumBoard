require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  sign_in_user
  let(:question) { create(:question) }
  let(:comment)  { create(:comment, commentable: question) }

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new comment' do
        expect do
          post :create, params: {
            question_id: question,
            comment: attributes_for(:comment),
            format: :json
          }
        end.to change(question.comments, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new comment' do
        expect do
          post :create, params: {
            question_id: question,
            comment: attributes_for(:invalid_comment),
            format: :json
          }
        end.to_not change(question.comments, :count)
      end
    end
  end
end
