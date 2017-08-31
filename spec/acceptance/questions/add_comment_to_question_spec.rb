require 'acceptance/acceptance_helper'

feature 'User adds comment to question', '
  In order to comment the question
  As an authenticated user
  I want to add comment
' do

  given(:user)     { create(:user) }
  given(:question) { create(:question) }

  describe 'Authenticated user tries to add comment', js: true do
    scenario 'with valid attributes' do
      Capybara.using_session('guest') do
        visit question_path(question)
        within('.question-wrapper') { expect(page)have_content 'Комментарии' }
      end

      Capybara.using_session('user') do
        sign_in(user)
        visit question_path(question)

        within('.question-wrapper') do
          click_on 'коментировать'
          fill_in 'Кометн', with: 'Lalalala'
          click_on 'Оставить'
          expect(page).to have_content 'Lalalala'
        end
      end

      Capybara.using_session('guest') { expect(page).to have_content 'Lalalala' }
    end
  end
end
