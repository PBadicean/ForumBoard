require 'acceptance/acceptance_helper'

feature 'Remove files from question', '
  In order to remove files
  An a author to question
  I want to be able to delete files
' do

  given(:author)      { create(:user) }
  given(:non_author)  { create(:user) }
  given(:question)    {create(:question, user: author) }
  given!(:attachment) { create(:attachment, attachable: question) }

  scenario 'Author remove file from question', js: true do
    sign_in author
    visit question_path(question)

    within('.question-attachments') do
      click_on 'удалить файл'
      expect(page).to have_no_link attachment.file.identifier
      expect(page).to have_no_link 'удалить файл'
    end
  end

  scenario 'Non-author tries to remove file from question' do
    sign_in non_author
    visit question_path(question)
    expect(page).to have_no_link 'удалить файл'
  end

  scenario 'Guest tries to remove file from question' do
    visit question_path(question)

    expect(page).to have_no_link 'удалить файл'
  end
end
