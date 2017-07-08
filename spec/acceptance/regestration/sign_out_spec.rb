require 'acceptance/acceptance_helper'

feature 'User tries to log out', '
  In order to finish the session
  As an authenticated User
  I want to log out
' do

  given(:user){ create(:user) }

  scenario 'Authenticated user tries to sign out' do
    sign_in(user)

    click_on 'Выйти'

    expect(current_path).to eq root_path
    expect(page).to have_content 'Signed out successfully.'
  end

  scenario 'Guest tries to sign out' do
    visit root_path

    expect(page).to have_no_link 'Выйти'
  end
end
