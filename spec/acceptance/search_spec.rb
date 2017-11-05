require 'acceptance/acceptance_helper'

feature 'User can search', '
  In order to get some object
  As an user or guest
  I want to search
' do

  given!(:question) { create(:question) }
  given!(:user)     { create(:user) }

  scenario 'User tries to search in all questions', js: true do
    sign_in(user)
    index
    visit root_path
    click_on 'Поиск'
    fill_in 'Запрос', with: question.title
    select 'Question', from: 'division'
    click_on 'Искать'
    expect(page).to have_link(question.title)
  end

end
