require 'acceptance/acceptance_helper'

feature 'All can to see all questions', '
  In order to see questions
  An a user
  I want to see all questions
' do
  given(:questions) { create_list(:question, 2) }

  scenario 'Human tries to see all questions' do
    questions
    visit questions_path

    questions.each do |question|
      expect(page).to have_link(question.title)
    end
  end
end
