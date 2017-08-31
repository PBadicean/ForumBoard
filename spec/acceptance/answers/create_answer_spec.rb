require 'acceptance/acceptance_helper'

feature 'Create answer', '
  In order answer questions
  An a user
  I want to be able to answer questions
' do

  given!(:user){ create(:user) }
  given(:question){ create(:question) }

  scenario 'Authenticated user tries to create answer', js: true do
    Capybara.using_session('guest') do
      visit question_path(question)
    end

    Capybara.using_session('user') do
      sign_in(user)
      visit question_path(question)

      fill_in 'Ответ', with: 'труляля'
      click_on 'Сохранить'
      wait_for_ajax

      within '.answers' do
        expect(page).to have_content 'труляля'
      end
    end

    Capybara.using_session('guest') do
      within('.answers') { expect(page).to have_content 'труляля' }
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
