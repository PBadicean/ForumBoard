# require 'acceptance/acceptance_helper'
#
# feature 'Others users can participate in voting', '
#   In order to vote for and down to question
#   An a other user
#   I want vote question
# ' do
#   given(:non_author) { create(:user) }
#   given(:author)     { create(:user) }
#   given(:question)   { create(:question, user: author) }
#
#   describe 'Non-Author user tries to vote question', js: true do
#     before do
#       sign_in non_author
#       visit question_path(question)
#    end
#
#     scenario 'can to vote for' do
#       click_on 'За вопрос'
#       expect(page).to have_content( 'Рейтинг вопроса 1')
#     end
#
#     scenario 'can to vote against' do
#       click_on 'Против вопроса'
#       expect(page).to have_content('Рейтинг вопроса -1')
#     end
#
#     describe 'vote 2 times' do
#       scenario 'for question' do
#         click_on 'За вопрос'
#         expect(page).to have_no_link 'За вопрос'
#         expect(page).to have_no_link 'Против вопроса'
#       end
#
#       scenario 'against question' do
#         click_on 'Против вопроса'
#         expect(page).to have_no_link 'За вопрос'
#         expect(page).to have_no_link 'Против вопроса'
#       end
#     end
#
#     describe 'can to vote again' do
#       scenario 'for question' do
#         click_on 'За вопрос'
#         click_on 'Переголосовать'
#         expect(page).to have_content 'Рейтинг вопроса 0'
#         expect(page).to have_link 'За вопрос'
#         expect(page).to have_link 'Против вопроса'
#         click_on 'За вопрос'
#         expect(page).to have_content 'Рейтинг вопроса 1'
#       end
#
#       scenario 'against question' do
#         click_on 'Против вопроса'
#         click_on 'Переголосовать'
#         expect(page).to have_content 'Рейтинг вопроса 0'
#         expect(page).to have_link 'За вопрос'
#         expect(page).to have_link 'Против вопроса'
#         click_on 'Против вопроса'
#         expect(page).to have_content 'Рейтинг вопроса -1'
#       end
#     end
#   end
#
#
#   scenario 'Author tries to vote question' do
#     sign_in author
#     visit question_path(question)
#
#     expect(page).to have_no_link 'За вопрос'
#     expect(page).to have_no_link 'Против вопроса'
#   end
#
#   scenario 'Non-Author tries to vote question' do
#     visit question_path(question)
#
#     expect(page).to have_no_link 'За вопрос'
#     expect(page).to have_no_link 'Против вопроса'
#   end
# end
