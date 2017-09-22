require 'rails_helper'

RSpec.describe OmniauthCallbacksController, type: :controller do

  describe 'GET #facebook' do
    before do
      request.env["devise.mapping"] = Devise.mappings[:user]
      request.env["omniauth.auth"] = mock_facebook_auth_hash
      get :facebook, params: { omniauth_auth: request.env['omniauth.auth'] }
    end

    it 'assigns the found user to @user' do
      expect(assigns(:user)).to be_a(User)
    end

    it 'redirects to root path' do
      expect(response).to redirect_to root_path
    end
  end
end
