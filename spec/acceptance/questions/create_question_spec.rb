require 'acceptance/acceptance_helper'

feature 'Create question', '
  In order to get answer from community
  An a user
  I want to be able to ask questions
' do

  given(:user){ create(:user) }

  scenario 'Authenticated user creates question'do
    sign_in(user)

    visit questions_path
    click_on 'Задать вопрос'
    fill_in 'Вопрос', with: 'Title'
    fill_in 'Содержимое', with: '123456789'
    click_on 'Сохранить'

    expect(page).to have_content 'Ваш вопрос успешно создан'
    expect(current_path).to eq question_path(Question.last)
  end

  scenario 'Non-Authenticated user tries to create question' do
    visit questions_path

    expect(page).to have_no_link 'Задать вопрос'
  end
end
