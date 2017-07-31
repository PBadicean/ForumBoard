require 'acceptance/acceptance_helper'

feature 'Add files to question', '
  In order to ilustrate my question
  An a author to question
  I want to be able to attach files
' do

  given(:user){ create(:user) }

  scenario 'User adds files', js: true do
    sign_in user
    visit new_question_path

    fill_in 'Вопрос', with: 'Title'
    fill_in 'Содержимое', with: '123456789'

    within all('.nested-fields').first do
      find('input[type="file"]').set("#{Rails.root}/spec/spec_helper.rb")
    end
    click_on 'еще один'

    within all('.nested-fields').last do
      find('input[type="file"]').set("#{Rails.root}/spec/rails_helper.rb")
    end

    click_on 'Сохранить'
    
    within '.question_attachments'do
      expect(page).to have_link 'spec_helper.rb', \
        href: "#{Rails.root}/spec/support/uploads/attachment/file/1/spec_helper.rb"
      expect(page).to have_link 'rails_helper.rb', \
        href: "#{Rails.root}/spec/support/uploads/attachment/file/2/rails_helper.rb"
    end
  end
end
