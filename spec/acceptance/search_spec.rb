require 'acceptance/acceptance_helper'

feature 'User can search', '
  In order to get some object
  As an user or guest
  I want to search
' do

  given!(:question) { create(:question) }
  given!(:comment)  { create(:comment, commentable: question) }
  given!(:answer)   { create(:answer, question: question) }
  given!(:user)     { create(:user) }

  background do
    index
    visit searches_path
  end

  describe 'Authenticated User tries to search ' do
    scenario 'question in all questions', js: true do
      fill_in 'Запрос', with: question.title
      select 'Question', from: 'division'
      click_on 'Искать'
      expect(page).to have_content(question.title)
    end

    scenario 'comment in all comments', js: true do
      fill_in 'Запрос', with: comment.body
      select 'Comment', from: 'division'
      click_on 'Искать'
      expect(page).to have_content(comment.body)
    end

    scenario 'answer in all answers', js: true do
      fill_in 'Запрос', with: answer.body
      select 'Answer', from: 'division'
      click_on 'Искать'
      expect(page).to have_content(answer.body)
    end

    scenario 'user in all users', js: true do
      fill_in 'Запрос', with: user.email
      select 'User', from: 'division'
      click_on 'Искать'
      expect(page).to have_content(user.email)
    end
  end

  describe 'User search Some object' do
    given!(:question) { create(:question, body: 'polina') }
    given!(:comment)  { create(:comment, commentable: question, body: 'polina') }
    given!(:answer)   { create(:answer, question: question, body: 'polina') }
    given!(:user)     { create(:user, email: 'polina@mail.ru') }

    scenario 'in all objects', js: true do
      fill_in 'Запрос', with: 'polina'
      select 'Everywhere', from: 'division'
      click_on 'Искать'
      expect(page).to have_content(user.email)
      expect(page).to have_content(answer.body)
      expect(page).to have_content(comment.body)
      expect(page).to have_link(question.body)
    end
  end
end
