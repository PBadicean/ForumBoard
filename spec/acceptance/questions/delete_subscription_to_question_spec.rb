require 'acceptance/acceptance_helper'

feature 'Unsubscribe to question', '
  In order to not get news about question
  An a user
  I want to be able to unsubscribe to question
' do
  given(:user)          {create(:user) }
  given(:question)      {create(:question) }
  given(:subscription) { create(:subscription, question: question, user: user) }

  scenario 'User tries to unsubscribe', js: true do
    sign_in(user)
    subscription
    visit question_path(question)

    within('.unsubscribe') { click_on 'Отписаться от вопроса' }
    expect(page).to have_no_link('Отписаться от вопроса')
    expect(page).to have_link 'Подписаться на вопрос'
  end

  scenario 'Guest tries to unsubscribe' do
    visit question_path(question)
    expect(page).to have_no_link('Отписаться от вопроса')
  end
end
