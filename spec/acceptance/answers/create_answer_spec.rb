require 'acceptance/acceptance_helper'

feature 'Create answer', '
  In order answer questions
  An a user
  I want to be able to answer questions
' do

  given(:user){ create(:user) }
  given(:question){ create(:question) }

  scenario 'Authenticated user creates answer', js: true do
    sign_in(user)
    visit question_path(question)

    fill_in 'Ответ', with: 'труляля'
    click_on 'Сохранить'
    expect(current_path).to eq question_path(question)
    within '.answers' do
      expect(page).to have_content 'труляля'
    end
  end

  scenario 'User tries create invalid answer', js: true do
    sign_in user
    visit question_path(question)

    click_on 'Сохранить'

    expect(page).to have_content "Body can't be blank"
  end

  scenario 'Non-Authenticated user tries to create answer' do
    visit question_path(question)

    expect(page).to have_no_link 'Сохранить'
  end
end
