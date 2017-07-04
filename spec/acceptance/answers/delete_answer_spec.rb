require 'rails_helper'

feature 'User-author can to delete his answer', '
  In order to delete answer
  An a user-author
  I want to delete answer
' do
  given(:author) {create(:user)}
  given(:user) {create(:user)}
  given(:question) {create(:question)}
  given!(:answer) {create(:answer, user: author, question: question)}

  scenario 'Author can to delete answer' do
    sign_in(author)
    visit question_path(question)
    click_on 'Удалить ответ'

    expect(page).to have_content 'Ваш ответ успешно удален'
    expect(current_path).to eq question_path(question)
  end

  scenario 'User tries to delete answer' do
    sign_in(user)
    visit question_path(question)

    expect(page).to have_no_link 'Удалить ответ'
  end

  scenario 'Guest tries to delete answer' do
    visit question_path(question)

    expect(page).to have_no_link 'Удалить ответ'
  end
end
