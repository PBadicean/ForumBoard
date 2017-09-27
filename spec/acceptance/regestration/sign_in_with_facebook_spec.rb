require 'acceptance/acceptance_helper'

feature 'User can sign in with facebook', '
  In order to be in my app
  As an authenticated or non-authenticated user
  I want to sign in with facebook
' do

  given(:user) { create(:user) }

  scenario 'User tries to register with facebook' do
    visit new_user_session_path
    mock_facebook_auth_hash
    click_on 'Sign in with Facebook'

    expect(current_path).to eq root_path
    expect(page).to have_content 'Successfully authenticated from Facebook account.'
  end

  scenario 'User already has authorization' do
    user.authorizations.create(provider: mock_facebook_auth_hash.provider, uid: mock_facebook_auth_hash.uid)

    visit new_user_session_path
    mock_facebook_auth_hash
    click_on 'Sign in with Facebook'

    expect(current_path).to eq root_path
    expect(page).to have_content 'Successfully authenticated from Facebook account.'
  end
end
