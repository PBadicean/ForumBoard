require 'acceptance/acceptance_helper'

feature 'User can sign in/up with twitter', '
  In order to use app
  As an authenticated user or guest
  I want to sign in/up with twitter
' do

  given(:user) { create(:user) }

  scenario 'User tries to register with twitter' do
    visit new_user_session_path
    click_on 'Sign in with Twitter'
    mock_twitter_auth_hash

    fill_in 'Email', with: 'new@mail.com'
    click_on 'Продолжить'

    open_email('new@mail.com')
    current_email.click_link 'Confirm my account'
  end
end
