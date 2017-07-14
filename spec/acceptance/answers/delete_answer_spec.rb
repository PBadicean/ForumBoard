require 'acceptance/acceptance_helper'

feature 'User-author can to delete his answer', '
  In order to delete answer
  An a user-author
  I want to delete answer
' do
  given(:author) {create(:user)}
  given(:user) {create(:user)}
  given(:question) {create(:question)}
  given!(:answer) {create(:answer, user: author, question: question)}

  scenario 'Author can to delete answer', js: true do
    sign_in(author)
    visit question_path(question)

    within '.answers' do
      click_on 'Удалить ответ'
      expect(page).to have_no_content answer.body
    end
  end

  scenario 'User tries to delete answer' do
    sign_in(user)
    visit question_path(question)

    within '.answers' do
      expect(page).to have_no_link 'Удалить ответ'
    end
  end

  scenario 'Guest tries to delete answer' do
    visit question_path(question)

    within '.answers' do
      expect(page).to have_no_link 'Удалить ответ'
    end
  end
end
