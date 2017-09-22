require 'acceptance/acceptance_helper'

feature 'Guest sign up', %q{
  In order to ask question
  As a guest
  I want to be able to sign up
} do

  scenario 'Guest tries to sign up' do
    visit new_user_registration_path

    fill_in 'Email', with: 'test@mail.ru'
    fill_in 'Password', with: '123456789'
    fill_in 'Password confirmation', with:'123456789'
    click_on 'Sign up'

    open_email('test@mail.ru')
    current_email.click_link 'Confirm my account'
    expect(current_path).to eq new_user_session_path
  end
end
