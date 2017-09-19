require 'acceptance/acceptance_helper'

feature 'User can sign in with facebook', '
  In order to be in my app
  As an authenticated or non-authenticated user
  I want to sign in with facebook
' do

  given!(:user) { create(:user) }

  scenario 'User tries to register with facebook' do
    visit new_user_session_path
    click_on 'Sign in with facebook'
    mock_facebook_auth_hash
    expect(current_path).to eq root_path
    expect(page).to have_content 'Вход в систему выполнен с учетной записью из Facebook.'
  end
end
