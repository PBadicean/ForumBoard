require 'acceptance/acceptance_helper'

feature 'Add subscription to question', '
  In order to get news about question
  An a user
  I want to be able to subscribe to question
' do

  given(:user)         { create(:user) }
  given(:question)     { create(:question) }

  scenario 'User tries to subscribe', js: true do
    sign_in user
    visit question_path(question)

    within('.subscribe') { click_on 'Подписаться на вопрос' }
    expect(page).to have_no_link 'Подписаться на вопрос'
  end

  scenario 'Guest tries to subscribe' do
    visit question_path(question)
    expect(page).to have_no_link 'Подписаться на вопрос'
  end
end
