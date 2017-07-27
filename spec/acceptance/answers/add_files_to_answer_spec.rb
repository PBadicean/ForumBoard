require 'acceptance/acceptance_helper'

feature 'Add files to answer', '
  In order to ilustrate my answer
  An a author to answer
  I want to be able to attach files
' do

  given(:user) {create(:user)}
  given(:question) {create(:question)}

  background do
    sign_in user
    visit question_path(question)
  end

  scenario 'User adds file when keep answer', js: true do
    fill_in 'Ответ', with: 'труляля'
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Сохранить'

    within '.answers'do
      expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
    end
  end
end
