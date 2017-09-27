require 'acceptance/acceptance_helper'

feature 'User can sign in with twitter', '
  In order to be in site
  As an authenticated user or guest
  I want to sign in with twitter
' do

  given(:user) { create(:user) }

  scenario 'User tries to register with twitter' do
    visit new_user_session_path
    mock_twitter_auth_hash
    click_on 'Sign in with Twitter'

    fill_in 'Email', with: 'new@mail.com'
    click_on 'Продолжить'

    open_email('new@mail.com')
    current_email.click_link 'Confirm my account'

    expect(page).to have_content 'Your email address has been successfully confirmed'
    click_on 'Sign in with Twitter'
    expect(page).to have_content 'Successfully authenticated from Twitter account.'
  end

  scenario 'User already has authorization' do
    user.authorizations.create(provider: mock_twitter_auth_hash.provider, uid: mock_twitter_auth_hash.uid)

    visit new_user_session_path
    click_on 'Sign in with Twitter'
    mock_twitter_auth_hash

    expect(current_path).to eq root_path
    expect(page).to have_content 'Successfully authenticated from Twitter account.'
  end
end
