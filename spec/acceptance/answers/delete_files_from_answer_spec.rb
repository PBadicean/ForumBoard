require 'acceptance/acceptance_helper'

feature 'Remove files from answer', '
  In order to remove files
  An a author to answer
  I want to be able to delete files
' do

  given(:author)      { create(:user) }
  given(:non_author)  { create(:user) }
  given(:question)    {create(:question)}
  given(:answer)      {create(:answer, user: author, question: question) }
  given!(:attachment) { create(:attachment, attachable: answer) }

  scenario 'Author remove file from answer', js: true do
    sign_in author
    visit question_path(question)

    within('.answer_attachments') do
      click_on 'удалить файл'
      expect(page).to have_no_link attachment.file.identifier
      expect(page).to have_no_link 'удалить файл'
    end
  end

  scenario 'Non-author tries to remove file from answer' do
    sign_in non_author
    visit question_path(question)

    within('.answer_attachments'){ expect(page).to have_no_link 'удалить файл' }
  end

  scenario 'Guest tries to remove file from answer' do
    visit question_path(question)

    within('.answer_attachments'){ expect(page).to have_no_link 'удалить файл' }
  end
end
