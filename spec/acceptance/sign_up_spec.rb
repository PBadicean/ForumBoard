require 'rails_helper'

feature 'Guest sign up', %q{
  In order to ask question
  As a guest
  I want to be able to sign up
} do

  scenario 'Guest tries to sign up' do
    visit new_user_registration_path

    fill_in 'Email', with: 'artem@daun.com'
    fill_in 'Password', with: '123456789'
    fill_in 'Password confirmation', with:'123456789'
    click_on 'Sign up'

    expect(current_path).to eq root_path
    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end
end
