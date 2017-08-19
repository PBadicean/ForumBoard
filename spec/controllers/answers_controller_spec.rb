require 'rails_helper'

RSpec.describe AnswersController, type: :controller do

  sign_in_user
  let(:answer) { create(:answer) }
  let(:question) { create(:question) }
  let(:answer_of_user) { create(:answer, user: @user, question: question) }


  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves the new answer in the database' do
        expect { post :create, params: { answer: attributes_for(:answer),
                                         question_id: question, format: :js
                                       } }.to change(question.answers, :count).by(1)
      end

      it 'Answer by current user saved' do
        expect { post :create, params: { answer: attributes_for(:answer),
                                         question_id: question, format: :js
                                       } }.to change(@user.answers, :count).by(1)
      end

      it 'render create template' do
        post :create, params: { answer: attributes_for(:answer),
                                question_id: question, format: :js }
        expect(response).to render_template 'create'
      end
    end

    context 'with invalid attributes' do
      it 'does not save the answer' do
        expect { post :create, params: { answer: attributes_for(:invalid_answer),
                                         question_id: question, format: :js
                                       } }.to_not change(question.answers, :count)
      end

      it 'render create template' do
        post :create, params: { answer: attributes_for(:invalid_answer),
                                question_id: question, format: :js }
        expect(response).to render_template 'create'
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'Author wants to delete answer' do
      it 'set question' do
        delete :destroy, params:{ id: answer_of_user,
                                question_id: question, format: :js }
        expect(assigns(:question)).to eq answer_of_user.question
      end

      it 'destroys answer' do
        answer_of_user
        expect do
          delete :destroy, params:{ id: answer_of_user,
                                    question_id: question, format: :js }
        end.to change(question.answers, :count).by(-1)
      end

      it 'renders template destroy' do
        delete :destroy, params:{ id: answer_of_user,
                                  question_id: question, format: :js }
        expect(response).to render_template 'destroy'
      end
    end

    context 'Non-Author wants to delete answer' do
      it 'not destroys answer' do
        answer
        expect do
          delete :destroy, params:{ id: answer,
                                    question_id: question, format: :js }
        end.to_not change(Answer, :count)
      end
    end
  end

  describe 'PATCH #update' do
    context 'Author tries to update his answer' do
      it 'assigns the requested answer to @answer' do
        patch :update, params: { id: answer_of_user, question_id: question,
                                 answer: attributes_for(:answer), format: :js}
        expect(assigns(:answer)).to eq answer_of_user
      end

      it 'changes answer attributes' do
        patch :update, params: { id: answer_of_user,
                                 question_id: question,
                                 answer: {body: 'new_body'}, format: :js}
        answer_of_user.reload
        expect(answer_of_user.body).to eq 'new_body'
      end

      it 'assigns the question' do
        patch :update, params: { id: answer_of_user,
                                 question_id: question,
                                 answer: attributes_for(:answer), format: :js}
        expect(assigns(:question)).to eq question
      end

      it 'render update template' do
        patch :update, params: { id: answer_of_user,
                                 question_id: question,
                                 answer: attributes_for(:answer), format: :js}
        expect(response).to render_template :update
      end
    end

    context 'Non author tries to update answer' do
      it 'does not change answer' do
        patch :update, params: { id: answer,
                                 answer: { body: 'new_body' },
                                 question_id: question, format: :js }
        answer.reload
        expect(answer.body).to_not eq 'new_body'
      end
    end
  end

  describe 'PATCH #accept' do
    sign_in_user
    let!(:answer) { create(:answer) }
    let!(:question) { create(:question, user: @user) }

    context 'Author tries to select best answer' do
      before { patch :accept, params: { id: answer,
                                        question_id: question, format: :js } }

      it 'checks that answer is first in list answers of question' do
        expect(assigns(:question).best_answer).to eq answer.id
      end

      it 'it render template accept' do
        expect(response).to render_template 'accept'
      end
    end

    context 'Non-author tries to select best answer' do
      it "does not change value of field 'best' to true" do
        expect do
          patch :accept, params: { id: answer,
                                   question_id: question, format: :js }
        end.to_not change { question.best_answer }
      end
    end
  end

  describe 'POST #up_vote' do
    sign_in_user

    context 'Non-author tries to vote for question' do
      it 'saves the new vote for question' do
        expect { post :up_vote, params: { id: answer,
                                          question_id: answer.question,
                                          format: :js
                                        } }.to change(answer.votes, :count).by(1)
      end
    end

    context 'Author tries to vote' do
      it 'does not create a new vote' do
        expect { post :up_vote, params: { id: answer_of_user,
                                          question_id: question,
                                          format: :json
                                  } }.to_not change(answer_of_user.votes, :count)
      end
    end
  end

  describe 'POST #down_vote' do
    sign_in_user

    context 'Non-author tries to vote against question' do
      it 'saves the new vote for question' do
        expect { post :down_vote, params: { id: answer,
                                            question_id: answer.question,
                                            format: :json
                                       } }.to change(answer.votes, :count).by(1)
      end
    end

    context 'Author tries to vote' do
      it 'does not create a new vote' do
        expect { post :down_vote, params: { id: answer_of_user,
                                            question_id: question,
                                            format: :json
                                          } }.to_not change(answer_of_user.votes, :count)
      end
    end
  end

  describe 'DELETE #revote' do
    sign_in_user
    let(:vote_of_author) { create(:vote, votable: answer, user: @user) }
    let(:vote) { create(:vote, votable: answer) }

    context 'Author the vote tries to revote' do
      it 'destroy vote of the hes author' do
        vote_of_author
        expect { delete :revote, params: { id: answer,
                                           question_id: answer.question,
                                           format: :json
                                          } }.to change(answer.votes, :count).by(-1)
      end
    end

    context 'Non-author the vote tries revote' do
      it 'destroy vote of the hes author' do
        vote
        expect { delete :revote, params: { id: answer,
                                           question_id: answer.question,
                                           format: :json
                                          } }.to_not change(answer.votes, :count)
      end
    end
  end
end
