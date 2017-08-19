require 'acceptance/acceptance_helper'

feature 'Others users can participate in voting', '
  In order to vote up and down to question
  An a other user
  I want vote question
' do
  given(:non_author) { create(:user) }
  given(:author)     { create(:user) }
  given(:question)   { create(:question, user: author) }

  scenario 'Human see rating question' do
    visit question_path(question)

    within('.question_rating') { expect(page).to have_content 'Рейтинг вопроса' }
  end

  describe 'Non-Author user tries to vote question', js: true do
    before do
      sign_in non_author
      visit question_path(question)
    end

    scenario 'He see link for vote' do
     within('.link-up-vote') { expect(page).to have_content('За вопрос') }
     within('.link-down-vote') { expect(page).to have_content('Против вопроса') }
    end

    scenario 'He can to up vote' do
      click_on 'За вопрос'
      expect(page).to have_content 'Вы успешно проголосовали за вопрос'
      within('.question_rating') { expect(page).to have_content 'Рейтинг вопроса 1' }
      expect(page).to have_no_link 'За вопрос'
      expect(page).to have_no_link 'Против вопроса'
      expect(page).to have_content 'Переголосовать'
    end

    scenario 'He can to down vote' do
      click_on 'Против вопроса'
      expect(page).to have_content 'Вы успешно проголосовали против вопроса'
      within('.question_rating') { expect(page).to have_content 'Рейтинг вопроса -1' }
      expect(page).to have_no_link 'За вопрос'
      expect(page).to have_no_link 'Против вопроса'
      expect(page).to have_content 'Переголосовать'
    end

    describe 'he can to revote' do
      scenario 'revote up question' do
        click_on 'За вопрос'
        within('.question_rating') { expect(page).to have_content 'Рейтинг вопроса 1' }
        click_on 'Переголосовать'
        within('.question_rating') { expect(page).to have_content 'Рейтинг вопроса 0' }
      end

      scenario 'revote down question' do
        click_on 'Против вопроса'
        within('.question_rating') { expect(page).to have_content 'Рейтинг вопроса -1' }
        click_on 'Переголосовать'
        within('.question_rating') { expect(page).to have_content 'Рейтинг вопроса 0' }
      end
    end
  end

  scenario 'Author can not to vote' do
    sign_in author
    visit question_path(question)

    expect(page).to have_no_link 'За вопрос'
    expect(page).to have_no_link 'Против вопроса'
  end

  scenario 'Non-authenticated can not to vote' do
    visit question_path(question)

    expect(page).to have_no_link 'За вопрос'
    expect(page).to have_no_link 'Против вопроса'
  end
end
