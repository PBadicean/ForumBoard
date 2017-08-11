require 'acceptance/acceptance_helper'

feature 'Others users can participate in voting', '
  In order to vote for and down to question
  An a other user
  I want vote question
' do
  given(:non_author) { create(:user) }
  given(:author)     { create(:user) }
  given(:question)   { create(:question, user: author) }

  describe 'Non-Author user tries to vote question', js: true do
    before do
      sign_in non_author
      visit question_path(question)
   end

    scenario 'can to vote for' do
      click_on 'За вопрос'
      expect(page).to have_content( 'Рейтинг вопроса 1')
    end
  end
end
