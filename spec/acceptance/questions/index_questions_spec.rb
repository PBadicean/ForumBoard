require 'rails_helper'

feature 'Human can to see all questions', '
  In order to see questions
  An a user
  I want to see all questions
' do


  scenario 'User tries to see all questions' do
    visit root_path

    expect(current_path).to eq root_path
    expect(page).to have_content 'Все вопросы'
  end

  scenario 'Guest tries to see all questions' do
    visit root_path

    expect(current_path).to eq root_path
    expect(page).to have_content 'Все вопросы'
  end
end
