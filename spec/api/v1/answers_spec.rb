require 'rails_helper'

describe 'Answers API' do
  let(:question)     { create(:question) }
  let(:answer)       { create(:answer, question: question) }
  let!(:attachment)  { create(:attachment, attachable: answer) }
  let!(:comment)     { create(:comment, commentable: answer) }
  let(:access_token) { create(:access_token) }

  describe 'GET /show' do
    it_behaves_like "API Authenticable"

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

      let(:attachable)   { answer }
      it_behaves_like "API Attachable"

      let(:commentable)  { answer }
      it_behaves_like "API Commentable"
    end

    def do_request(options = {})
      get "/api/v1/questions/#{question.id}/answers/#{answer.id}",
      params: { format: :json }.merge(options)
    end
  end

  describe 'POST /create' do
    it_behaves_like "API Authenticable"

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

    def do_request(options = {})
      post "/api/v1/questions/#{question.id}/answers",
      params: { format: :json }.merge(options)
    end
  end
end
