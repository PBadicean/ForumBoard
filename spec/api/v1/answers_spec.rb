require 'rails_helper'

describe 'Answers API' do
  let(:question)     { create(:question) }
  let(:answer)       { create(:answer, question: question) }
  let!(:attachment)  { create(:attachment, attachable: answer) }
  let!(:comment)     { create(:comment, commentable: answer) }
  let(:access_token) { create(:access_token) }

  describe 'GET /show' do
    context 'unauthorized' do
      it 'returns 401 status if there is no access_token' do
        get "/api/v1/questions/#{question.id}/answers/#{answer.id}",
          params: { format: :json }
        expect(response.status).to eq 401
      end

      it 'returns 401 status if access_token is invalid' do
        get "/api/v1/questions/#{question.id}/answers/#{answer.id}",
        params: { format: :json, access_token: '1234' }
        expect(response.status).to eq 401
      end
    end

    context 'authorized' do
      before { get "/api/v1/questions/#{question.id}/answers/#{answer.id}",
               params: { format: :json, access_token: access_token.token } }

      it 'returns 200 status code' do
        expect(response).to be_success
      end

      it 'returns answer of question' do
        expect(response.body).to have_json_size(1)
      end

      %w(id body created_at updated_at user_id question_id).each do |attr|
        it "contains #{attr}" do
          expect(response.body).to be_json_eql(
            answer.send(attr.to_sym).to_json).at_path("answer/#{attr}")
        end
      end

      context 'attachments' do
        it 'include in answer attachments' do
          expect(response.body).to have_json_size(1).at_path("answer/attachments")
        end

        it 'contains attachment url' do
          expect(response.body).to be_json_eql(
            attachment.file.url.to_json).at_path('answer/attachments/0/url')
        end

        %w(id file created_at updated_at attachable_id attachable_type).each do |attr|
          it "doesn't contains #{attr}" do
            expect(response.body).to_not have_json_path("answer/attachments/0/#{attr}")
          end
        end
      end

      context 'comments' do
        it 'include in answer comments' do
          expect(response.body).to have_json_size(1).at_path("answer/comments")
        end

        %w(id created_at updated_at commentable_type commentable_id body user_id).each do |attr|
          it "contains #{attr}" do
            expect(response.body).to be_json_eql(
              comment.send(attr.to_sym).to_json).at_path("answer/comments/0/#{attr}")
          end
        end
      end
    end
  end

  describe 'POST /create' do
    context 'unauthorized' do
      it 'returns 401 status if there is no access_token' do
        post "/api/v1/questions/#{question.id}/answers", params: { format: :json }
        expect(response.status).to eq 401
      end

      it 'returns 401 status if access_token is invalid' do
        post "/api/v1/questions/#{question.id}/answers/",
        params: { format: :json, access_token: '1234' }
        expect(response.status).to eq 401
      end
    end

    context 'authorized' do
      it 'returns 200 status code' do
        post "/api/v1/questions/#{question.id}/answers",
        params: { answer: attributes_for(:answer), question_id: question,
                  access_token: access_token.token, format: :json }
        expect(response).to be_success
      end

      it 'returns answer of question' do
        post "/api/v1/questions/#{question.id}/answers",
        params: { answer: attributes_for(:answer), question_id: question,
                  access_token: access_token.token, format: :json }
        expect(response.body).to have_json_size(1)
      end

      it 'saves the new answer for question' do
        expect do
          post "/api/v1/questions/#{question.id}/answers",
          params: { answer: attributes_for(:answer), question_id: question,
                    access_token: access_token.token, format: :json }
        end.to change(question.answers, :count).by(1)
      end

      %w[id body created_at updated_at user_id question_id].each do |attr|
        it "contains answer #{attr}" do
          post "/api/v1/questions/#{question.id}/answers",
          params: { answer: attributes_for(:answer), question_id: question,
                    access_token: access_token.token, format: :json }
          expect(response.body).to be_json_eql(
            assigns(:answer).send(attr.to_sym).to_json).at_path("answer/#{attr}")
        end
      end
    end
  end
end
