require 'acceptance/acceptance_helper'

feature 'Others users can participate in voting', '
  In order to vote up and down to answer
  An a other user
  I want vote answer
' do

  given(:non_author) { create(:user) }
  given(:author)     { create(:user) }
  given(:question)   { create(:question) }
  given!(:answer)     { create(:answer, question: question, user: author) }

  describe 'Non-Author user tries to vote answer', js: true do
    background do
      sign_in non_author
      visit question_path(question)
   end

    scenario 'He can to up vote' do
      click_on 'За ответ'
      expect(page).to have_content 'Вы успешно проголосовали за ответ'
      expect(page).to have_content 'Рейтинг ответа 1'
    end

    scenario 'He can to down vote' do
      click_on 'Против ответа'
      expect(page).to have_content 'Вы успешно проголосовали против ответа'
      expect(page).to have_content 'Рейтинг ответа -1'
    end

    describe 'to vote 2 times' do
      scenario 'up' do
        click_on 'За ответ'
        expect(page).to have_no_link 'За ответ'
        expect(page).to have_no_link 'Против ответа'
        page.reset!
        expect(page).to have_no_link 'За ответ'
        expect(page).to have_no_link 'Против ответа'
      end

      scenario 'down' do
        click_on 'Против ответа'
        expect(page).to have_no_link 'За ответ'
        expect(page).to have_no_link 'Против ответа'
        page.reset!
        expect(page).to have_no_link 'За ответ'
        expect(page).to have_no_link 'Против ответа'
      end
    end

    describe 'he can to revote' do
      scenario 'up answer' do
        click_on 'За ответ'
        expect(page).to have_content 'Рейтинг ответа 1'
        within('.answers') { click_on 'Переголосовать' }
        expect(page).to have_content 'Рейтинг ответа 0'
        click_on 'За ответ'
        expect(page).to have_content 'Рейтинг ответа 1'
      end

      scenario 'down answer' do
        click_on 'Против ответа'
        expect(page).to have_content 'Рейтинг ответа -1'
        within('.answers') { click_on 'Переголосовать' }
        expect(page).to have_content 'Рейтинг ответа 0'
        click_on 'Против ответа'
        expect(page).to have_content 'Рейтинг ответа -1'
      end
    end
  end

  scenario 'Author can not to vote', js: true do
    sign_in author
    visit question_path(question)
    # save_and_open_page

    expect(page).to have_no_link 'За ответ'
    expect(page).to have_no_link 'Против ответа'
  end

  scenario 'Non-authenticated can not to vote', js: true do
    visit question_path(question)

    expect(page).to have_no_link 'За ответ'
    expect(page).to have_no_link 'Против ответа'
  end
end
