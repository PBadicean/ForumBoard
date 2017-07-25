require 'acceptance/acceptance_helper'

feature "Edit question', '
  In order to fix mistake
  An a author of question
  I'd like ot be able to edit my question
" do

  given(:author) { create(:user) }
  given(:non_author) { create(:user) }
  given!(:question) { create(:question, user: author) }

  scenario 'Authenticated user edit question', js: true do
    sign_in author
    visit question_path(question)

    click_on 'Редактировать'
    expect(page).to have_no_link 'Редактировать'

    within '.edit_question' do
      fill_in 'Вопрос', with: 'новый вопрос'
      fill_in 'Содержимое', with: 'новое содержимое'
      click_on 'Сохранить'
      wait_for_ajax
    end

    within '.question-wrapper' do
      expect(page).to have_content 'новый вопрос'
      expect(page).to have_content 'новое содержимое'
    end

    expect(page).to have_link 'Редактировать'

  end

  scenario "Other user try to edit question" do
    sign_in non_author
    visit question_path(question)

    expect(page).to_not have_link 'Редактировать'
  end

  scenario 'Unauthenticated user try to edit question' do
    visit question_path(question)

    expect(page).to_not have_link 'Редактировать'
  end
end
