require 'rails_helper'

feature 'Create answer', '
  In order answer questions
  An a user
  I want to be able to answer questions
' do

  given(:user){ create(:user) }
  given(:question){ create(:question) }

  scenario 'Authenticated user creates answer'do
    sign_in(user)
    visit question_path(question)

    fill_in 'Body', with: 'труляля'
    click_on 'ответить'

    expect(page).to have_content 'Ваш ответ успешно добален'
    expect(current_path).to eq question_path(question)
  end

  scenario 'Non-Authenticated user tries to create answer' do
    visit question_path(question)

    expect(page).to have_no_link 'ответить'
  end
end
