require 'acceptance/acceptance_helper'

feature 'User can add comment to answer', '
  In order to evaluate the answer
  As an authenticated user
  I want to add comment
' do

  given(:user)     { create(:user) }
  given(:question) { create(:question) }
  given!(:answer)  { create(:answer, question: question) }

  describe 'Authenticated user tries to add comment', js: true do
    scenario 'with valid attributes' do
      Capybara.using_session('guest') do
        visit question_path(question)
        within('.answer-wrapper') { click_on 'Комментарии' }
      end

      Capybara.using_session('user') do
        sign_in user
        visit question_path(question)

        within('.answer-wrapper') do
          click_on 'Комментарии'
          fill_in 'Комент', with: 'My comment'
          click_on 'Отправить'
          wait_for_ajax
          expect(page).to have_content 'My comment'
        end
      end

      Capybara.using_session('guest') { expect(page).to have_content 'My comment' }
    end

    scenario 'with invalid attributes' do
      sign_in user
      visit question_path(question)

      within('.answer-wrapper') do
        click_on 'Комментарии'
        fill_in 'Комент', with: ''
        click_on 'Отправить'
        expect(page).to have_content "can't be blank"
      end
    end
  end

  scenario 'guest tries to add comment' do
    visit question_path(question)

    within('.answer-wrapper') do
      click_on 'Комментарии'
      expect(page).to_not have_button('Отправить')
    end
  end
end
