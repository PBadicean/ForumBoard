require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  sign_in_user

  describe 'GET #finish_signup' do
    it 'render template finish_signup' do
      get :finish_signup, params: { id: @user.id }
      expect(response).to render_template 'finish_signup'
    end
  end

  describe 'PATCH #finish_signup' do
    it 'updates params user of email' do
      patch :finish_signup, params: { id: @user.id, user: { email: 'polina@gmail.com' } }
      @user.reload
      expect(@user.unconfirmed_email).to eq 'polina@gmail.com'
    end
  end
end
