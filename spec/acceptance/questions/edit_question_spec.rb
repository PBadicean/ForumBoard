require 'acceptance/acceptance_helper'

feature "Edit question', '
  In order to fix mistake
  An a author of question
  I'd like ot be able to edit my question
" do

  given(:author) { create(:user) }
  given(:user) { create(:user) }
  given!(:question) { create(:question, user: author) }

  scenario 'Authenticated user edit question', js: true do
    sign_in author
    visit question_path(question)

    expect(page).to have_link 'Редактировать'
    click_on 'Редактировать'

    fill_in 'Вопрос', with: 'измененный вопрос'
    fill_in 'Содержимое', with: 'измененное содержимое'
    click_on 'Сохранить'

    expect(page).to_not have_content question.body
    expect(page).to have_content 'измененный вопрос'
    expect(page).to have_content 'измененное содержимое'
    expect(page).to_not have_selector 'textarea'
  end

  scenario "Other user try to edit question" do
    sign_in user
    visit question_path(question)

    expect(page).to_not have_link 'Редактировать'
  end

  scenario 'Unauthenticated user try to edit question' do
    visit question_path(question)

    expect(page).to_not have_link 'Редактировать'
  end
end
