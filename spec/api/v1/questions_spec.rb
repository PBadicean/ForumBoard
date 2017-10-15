require 'rails_helper'

describe 'Questions API' do
  describe 'GET /index' do
    it_behaves_like "API Authenticable"

    context 'authorized' do
      let(:access_token) { create(:access_token) }
      let!(:questions)   { create_list(:question, 2) }
      let(:question)     { questions.first }

      before { get '/api/v1/questions', params: { format: :json, access_token: access_token.token } }

      it 'returns 200 status code' do
        expect(response).to be_success
      end

      it 'returns list of questions' do
        expect(response.body).to have_json_size(2).at_path('questions')
      end

      %w(id body title created_at updated_at user_id best_answer).each do |attr|
        it "question object contains #{attr}" do
          expect(response.body).to be_json_eql(question.send(attr.to_sym).to_json).at_path("questions/0/#{attr}")
        end
      end
    end

    def do_request(options = {})
      get '/api/v1/questions', params: { format: :json }.merge(options)
    end
  end

  describe 'GET /show' do
    let!(:question) { create(:question) }
    it_behaves_like "API Authenticable"

    context 'authorized' do
      let(:access_token) { create(:access_token) }
      let!(:answer)      { create(:answer, question: question) }
      let!(:attachment)  { create(:attachment, attachable: question) }
      let!(:comment)     { create(:comment, commentable: question) }

      before { get "/api/v1/questions/#{question.id}", params: { format: :json, access_token: access_token.token } }

      it 'returns 200 status code' do
        expect(response).to be_success
      end

      it 'returns one question' do
        expect(response.body).to have_json_size(1)
      end

      %w(id body title created_at updated_at best_answer user_id).each do |attr|
        it "contains parameter question #{attr}" do
          expect(response.body).to be_json_eql(
            question.send(attr.to_sym).to_json).at_path("question/#{attr}")
        end
      end

      it 'contains question schort_title' do
        expect(response.body).to be_json_eql(
          question.title.truncate(10).to_json).at_path("question/schort_title")
      end

      context 'answers' do
        it 'include in question answers' do
          expect(response.body).to have_json_size(1).at_path("question/answers")
        end

        %w(question_id id body created_at updated_at user_id).each do |attr|
          it "contains #{attr}" do
            expect(response.body).to be_json_eql(
              answer.send(attr.to_sym).to_json).at_path("question/answers/0/#{attr}")
          end
        end
      end

      let(:attachable)   { question }
      it_behaves_like "API Attachable"

      context 'comments' do
        it 'include in question attachments' do
          expect(response.body).to have_json_size(1).at_path("question/attachments")
        end

        %w(id created_at updated_at commentable_type commentable_id body user_id).each do |attr|
          it "contains #{attr}" do
            expect(response.body).to be_json_eql(
              comment.send(attr.to_sym).to_json).at_path("question/comments/0/#{attr}")
          end
        end
      end
    end

    def do_request(options = {})
      get "/api/v1/questions/#{question.id}",
      params: { format: :json }.merge(options)
    end
  end

  describe 'POST /create' do
    it_behaves_like "API Authenticable"

    context 'authorized' do
      let(:access_token) { create(:access_token) }

      it 'returns 200 status code' do
        post "/api/v1/questions",
        params: { question: attributes_for(:question),
                  access_token: access_token.token, format: :json }
        expect(response).to be_success
      end

      it 'saves the new question' do
        expect do
          post "/api/v1/questions",
          params: { question: attributes_for(:question),
                    access_token: access_token.token, format: :json }
        end.to change(Question, :count).by(1)
      end

      it 'returns one question' do
        post "/api/v1/questions/",
        params: { question: attributes_for(:question),
                  access_token: access_token.token, format: :json }
        expect(response.body).to have_json_size(1)
      end


      %w[id title body created_at updated_at user_id ].each do |attr|
        it "contains question #{attr}" do
          post "/api/v1/questions",
          params: { question: attributes_for(:question),
                    access_token: access_token.token, format: :json }
          expect(response.body).to be_json_eql(
            assigns(:question).send(attr.to_sym).to_json).at_path("question/#{attr}")
        end
      end

      it 'contains question schort_title' do
        post "/api/v1/questions",
        params: { question: attributes_for(:question),
                  access_token: access_token.token, format: :json }
        expect(response.body).to be_json_eql(
          assigns(:question).title.truncate(10).to_json).at_path("question/schort_title")
      end
    end

    def do_request(options = {})
      post "/api/v1/questions", params: { format: :json }.merge(options)
    end
  end
end
