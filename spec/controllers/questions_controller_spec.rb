require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do

  describe 'GET #index' do
    let(:questions) { create_list(:question, 2) }

    before { get :index }

    it 'populates an array of all questions' do
      expect(assigns(:questions)).to match_array(questions)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    let(:question) { create(:question) }

    before { get :show, params: { id: question } }

    it 'assigns the requested question to @question'do
      expect(assigns(:question)).to eq question
    end

    it 'assigns a new Answer to @answer' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    sign_in_user

    before { get :new }

    it 'assigns a new Question to @question' do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    context 'Authenticated user can to create' do
      sign_in_user
      context 'with valid attributes' do
        it 'saves the new question in the database' do
          expect { post :create, params: { question: attributes_for(:question) } }.to change(Question, :count).by(1)
        end

        it 'redirects to show view' do
          post :create, params: { question: attributes_for(:question) }
          expect(response).to redirect_to question_path(assigns(:question))
        end
      end

      context 'with invalid attributes' do
        it 'does not save the question' do
          expect { post :create, params: { question: attributes_for(:invalid_question) } }.to_not change(Question, :count)
        end

        it 're-redirects new view' do
          post :create, params: { question: attributes_for(:invalid_question) }
          expect(response).to render_template :new
        end
      end
    end

    context 'Non-Authenticated user tries to create' do
      context 'with valid attributes' do
        it 'do not saves the new question in the database' do
          expect { post :create, params: { question: attributes_for(:question) } }.to_not change(Question, :count)
        end
      end
    end
  end

  describe 'DELETE #destroy'do
    sign_in_user
    let(:question) { create(:question, user: @user) }

    context 'Current user is author' do
      it 'deletes question' do
        question
        expect { delete :destroy, params: { id: question } }.to change(Question, :count).by(-1)
      end

      it 'redirect to index view' do
        delete :destroy, params: { id: question }
        expect(response).to redirect_to questions_path
      end
    end

    context 'Current user is not author' do
      let(:another_user) { create(:user) }
      let(:another_question) { create(:question, user: another_user) }

      it 'deletes question' do
        another_question
        expect { delete :destroy, params: { id: another_question } }.to_not change(Question, :count)
      end

      it 'redirect to index view' do
        delete :destroy, params: { id: another_question }
        expect(response).to render_template :show
      end
    end
  end
end
