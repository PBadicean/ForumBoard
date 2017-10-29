require 'rails_helper'

RSpec.describe SubscriptionsController, type: :controller do
  sign_in_user
  let(:question) { create(:question, user: @user) }

  describe 'POST #create' do
    context 'Authenticated user can to subscribe' do
      it 'saves subscription in data-base' do
        expect do
          post :create, params: {
            subscription: attributes_for(:subscription),
            question_id: question,
            format: :js }
        end.to change(question.subscriptions, :count).by(1)
      end

      it 'render template create' do
        post :create, params: {
          question_id: question,
          subscription: attributes_for(:subscription),
          format: :js }
        expect(response).to render_template 'create'
      end
    end
  end

  describe 'POST #destroy' do
    context 'Authenticated user can to unsubscribe' do
      let!(:subscription) { create(:subscription, question: question, user: @user) }

      it 'destroy subscription in data-base' do
        expect do
          delete :destroy, params: {
            id: subscription,
            question_id: question,
            format: :js }
        end.to change(question.subscriptions, :count)
      end

      it 'render template destroy' do
        delete :destroy, params: {
          id: subscription,
          question_id: question,
          format: :js }
        expect(response).to render_template 'destroy'
      end
    end
  end
end
