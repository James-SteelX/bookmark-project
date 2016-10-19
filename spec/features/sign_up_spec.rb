require 'spec_helper'
require './app/models/user'

feature 'User can sign up' do
  scenario 'As a new user I can sign up' do
    visit '/users/sign_up'
    expect(page.status_code).to eq(200)
    fill_in :email,   with: 'joe@email.com'
    fill_in :password, with: 'abc123'
    expect{ click_button 'Sign up' }.to change(User, :count).by(1)
    expect(page).to have_content('Welcome joe@email.com')
    expect(User.first.email).to eq 'joe@email.com'
  end
end
