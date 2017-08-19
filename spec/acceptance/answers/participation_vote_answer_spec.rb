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
    before do
      sign_in non_author
      visit question_path(question)
   end

    scenario 'He see link for vote' do
      within('.link-up-vote-answer') { expect(page).to have_content('За ответ') }
      within('.link-down-vote-answer') { expect(page).to have_content('Против ответа') }
    end

    scenario 'He can to up vote' do
      click_on 'За ответ'
      expect(page).to have_content 'Вы успешно проголосовали за ответ'
      within('.answer_rating') { expect(page).to have_content 'Рейтинг ответа 1' }
      expect(page).to have_no_link 'За ответ'
      expect(page).to have_no_link 'Против ответа'
      within('.revote_answer') { expect(page).to have_content 'Переголосовать' }
    end

    scenario 'He can to down vote' do
      click_on 'Против ответа'
      expect(page).to have_content 'Вы успешно проголосовали против ответа'
      within('.answer_rating') { expect(page).to have_content 'Рейтинг ответа -1' }
      expect(page).to have_no_link 'За ответ'
      expect(page).to have_no_link 'Против ответа'
      expect(page).to have_content 'Переголосовать'
    end

    describe 'he can to revote' do
      scenario 'up answer' do
        click_on 'За ответ'
        within('.answer_rating') { expect(page).to have_content 'Рейтинг ответа 1' }
        click_on 'Переголосовать'
        within('.answer_rating') { expect(page).to have_content 'Рейтинг ответа 0' }
      end

      scenario 'down answer' do
        click_on 'Против ответа'
        within('.answer_rating') { expect(page).to have_content 'Рейтинг ответа -1' }
        click_on 'Переголосовать'
        within('.answer_rating') { expect(page).to have_content 'Рейтинг ответа 0' }
      end
    end
  end

  scenario 'Author can not to vote' do
    sign_in author
    visit question_path(question)

    expect(page).to have_no_link 'За ответ'
    expect(page).to have_no_link 'Против ответа'
  end

  scenario 'Non-authenticated can not to vote' do
    visit question_path(question)

    expect(page).to have_no_link 'За ответ'
    expect(page).to have_no_link 'Против ответа'
  end
end
