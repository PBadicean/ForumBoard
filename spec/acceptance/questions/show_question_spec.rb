require 'rails_helper'

feature 'All users can to see question', '
  In order to see question
  An a user
  I want to see question
' do
  given(:question) { create(:question) }
  given(:answers) { create_list(:answer, 2, question: question) }

  scenario 'User tries to see question' do
    question
    answers

    visit question_path(question)
    expect(page).to have_content(question.title)
    expect(page).to have_content(question.body)

    answers.each do |answer|
      expect(page).to have_content(answer.body)
    end
  end
end
