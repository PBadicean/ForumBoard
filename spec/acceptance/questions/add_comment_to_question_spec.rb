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
        within('.question-wrapper') { click_on 'Комментарии' }
      end

      Capybara.using_session('user') do
        sign_in(user)
        visit question_path(question)

        within('.question-wrapper') do
          click_on 'Комментарии'
          fill_in 'Комент', with: 'Lalalala'
          click_on 'Отправить'
          expect(page).to have_content 'Lalalala'
       end
     end

      Capybara.using_session('guest') do
        expect(page).to have_content 'Lalalala'
      end
    end

    scenario 'with invalid attributes' do
      sign_in user
      visit question_path(question)

      within('.question-wrapper') do
        click_on 'Комментарии'
        fill_in 'Комент', with: ''
        click_on 'Отправить'
        expect(page).to have_content "body can't be blank"
      end
    end
  end
end
