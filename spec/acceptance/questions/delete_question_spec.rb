require 'acceptance/acceptance_helper'

feature 'User-author can to delete his question', '
  In order to delete question
  An a user-author
  I want to delete question
' do
  given(:author) {create(:user)}
  given(:non_author) {create(:user)}
  given(:question) {create(:question, user: author)}

  scenario 'Author can to delete his question' do
    sign_in(author)
    visit question_path(question)
    click_on 'Удалить'

    expect(page).to have_content 'Question was successfully destroyed.'
    expect(current_path).to eq questions_path
  end

  scenario 'Non author wants to delete question' do
    sign_in(non_author)
    visit question_path(question)

    expect(page).to have_no_link('Удалить')
  end

  scenario 'Guest wants to delete answer' do
    visit question_path(question)

    expect(page).to have_no_link('Удалить')
  end
end
