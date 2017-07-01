require 'rails_helper'

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
    fill_in 'Title', with: 'Title'
    fill_in 'Body', with: '123456789'
    click_on 'Создать'

    expect(page).to have_content 'Ваш вопрос успешно создан'
    expect(current_path).to eq question_path(Question.last)
  end

  scenario 'Non-Authenticated user tries to create question' do
    visit questions_path
    click_on 'Задать вопрос'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
