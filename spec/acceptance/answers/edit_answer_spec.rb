require 'acceptance/acceptance_helper'

feature "Edit answer', '
  In order to fix mistake
  An a author of answer
  I'd like ot be able to edit my answer
" do

  given(:author) { create(:user) }
  given(:non_author) { create(:user) }
  given(:question) { create(:question) }
  given!(:answer) { create(:answer, question: question, user: author) }

  scenario 'Authenticated user tries to edit his answer', js: true do
    sign_in author
    visit question_path(question)

    within '.answers' do
      click_on 'Редактировать'
      fill_in 'Ответ', with: 'изменный ответ'
      click_on 'Сохранить'

      expect(page).to_not have_content answer.body
      expect(page).to have_content 'изменный ответ'
      expect(page).to_not have_selector 'textarea'
    end
  end

  scenario "Other user try to edit question" do
    sign_in non_author
    visit question_path(question)

    within '.answers' do
      expect(page).to_not have_link 'Редактировать'
    end
  end

  scenario 'Unauthenticated user try to edit question' do
    visit question_path(question)

    within '.answers' do
      expect(page).to_not have_link 'Редактировать'
    end
  end
end
