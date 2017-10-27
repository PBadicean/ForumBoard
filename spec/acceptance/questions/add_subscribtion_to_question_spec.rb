require 'acceptance/acceptance_helper'

feature 'Add subscription to question', '
  In order to get news about question
  An a user the question
  I want to be able to subscribe to question
' do

  given(:user){ create(:user) }
  given(:question){ create(:question) }

  scenario 'User tries to subscribe' do
    sign_in user
    visit question_path(question)

    click_on 'Подписаться на вопрос'
    expect(page).to have_no_link 'Подписаться на вопрос'
  end
end
