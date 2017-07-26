require 'acceptance/acceptance_helper'

feature 'Add files to question', '
  In order to ilustrate my question
  An a author to question
  I want to be able to attach files
' do

  given(:user) {create(:user)}
  background do
    sign_in user
    visit new_question_path
  end

  scenario 'User adds file when asks question' do
    fill_in 'Вопрос', with: 'Title'
    fill_in 'Содержимое', with: '123456789'
    attach_file 'Фаил', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Сохранить'

    expect(page).to have_content 'spec_helper.rb'
  end

end
