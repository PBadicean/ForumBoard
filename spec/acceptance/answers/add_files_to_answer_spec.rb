require 'acceptance/acceptance_helper'

feature 'Add files to answer', '
  In order to ilustrate my answer
  An a author to answer
  I want to be able to attach files
' do

  given(:user) {create(:user)}
  given(:question) {create(:question)}

  scenario 'User adds file when keep answer', js: true do
    sign_in user
    visit question_path(question)

    fill_in 'Ответ', with: 'труляля'
    click_on 'добавить файл'

    within all("#attachments > .nested-fields").first do
      find('input[type="file"]').set("#{Rails.root}/spec/spec_helper.rb")
    end

    click_on 'добавить файл'
    within all("#attachments > .nested-fields").last do
      find('input[type="file"]').set("#{Rails.root}/spec/rails_helper.rb")
    end

    click_on 'Сохранить'

    within '.answer-attachments'do
      expect(page).to have_link 'spec_helper.rb', \
        href: "#{Rails.root}/spec/support/uploads/attachment/file/1/spec_helper.rb"
      expect(page).to have_link 'rails_helper.rb', \
        href: "#{Rails.root}/spec/support/uploads/attachment/file/2/rails_helper.rb"
    end
  end
end
