require 'acceptance/acceptance_helper'

feature 'Select best answer', '
In order to close question
As an author own question
I want to select best answer
' do

  given(:non_author){ create(:user) }
  given(:author){ create(:user) }
  given(:question){ create(:question, user: author) }
  given!(:answers){ create_list(:answer, 2, question: question, user: non_author) }

  describe 'Author tries to', js: true do
    scenario 'select best answer'do
      sign_in author
      visit question_path(question)
      answers

      within ".answers div[data-answer-id='#{answers.last.id}']"  do
        click_on 'Это лучший'
        wait_for_ajax
      end

      expect(first('.answers div')).to eq find(".answers div[data-answer-id='#{answers.last.id}']")
      expect(first('.answers div')).to have_no_link('Это лучший')
    end
  end

  scenario 'Non-Author tries to select best answer' do
    sign_in non_author

    visit question_path(question)

    within '.answers' do
      expect(page).to have_no_link('Это лучший')
    end
  end

  scenario 'Guest tries to select best answer' do
    visit question_path(question)

    within '.answers' do
      expect(page).to have_no_link('Это лучший')
    end
  end
end
