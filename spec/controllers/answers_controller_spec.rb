require 'rails_helper'

RSpec.describe AnswersController, type: :controller do

  let(:answer) { create(:answer) }
  let(:question) { create(:question) }

  describe 'POST #create' do
    sign_in_user

    context 'with valid attributes' do
      it 'saves the new answer in the database' do
        expect { post :create, params: { answer: attributes_for(:answer),
                                         question_id: question
                                       } }.to change(question.answers, :count).by(1)
      end

      it 'Answer by current user saved' do
        expect { post :create, params: { answer: attributes_for(:answer),
                                         question_id: question
                                       } }.to change(@user.answers, :count).by(1)
      end

      it 'redirects question show view' do
        post :create, params: { answer: attributes_for(:answer), question_id: question}
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end

    context 'with invalid attributes' do
      it 'does not save the answer' do
        expect { post :create, params: { answer: attributes_for(:invalid_answer),
                                         question_id: question
                                       } }.to_not change(question.answers, :count)
      end

      it 're-redirects question show view' do
        post :create, params: { answer: attributes_for(:invalid_answer), question_id: question}
        expect(response).to render_template 'questions/show'
      end
    end
  end

  describe 'DELETE #destroy' do
    sign_in_user
    let!(:answer_of_user) { create(:answer, user: @user) }

    context 'Author tries to delete his answer' do
      it 'deletes the @answer' do
        expect { delete :destroy, params: { id: answer_of_user } }.to change(Answer, :count).by(-1)
      end

      it 'redirects to question of answer' do
        delete :destroy, params: { id: answer_of_user }
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end

    context 'Non-Author tries to delete  answer' do
      it 'does not delete the @answer' do
        answer
        expect { delete :destroy, params: { id: answer } }.to_not change(Answer, :count)
      end

      it 'render question of answer view' do
        delete :destroy, params: { id: answer }
        expect(response).to render_template 'questions/show'
      end
    end
  end
end
