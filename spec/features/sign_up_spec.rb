require 'spec_helper'
require './app/models/user'
require_relative 'web_helper'

feature 'User can sign up' do
  scenario 'As a new user I can sign up' do
    expect{ sign_up }.to change(User, :count).by(1)
    expect(page).to have_content('Welcome joe@email.com')
    expect(User.first.email).to eq 'joe@email.com'
  end

  scenario 'User inputs wrong password' do
    expect{ bad_sign_up }.to change(User, :count).by(0)
    expect(page).to have_content('Passwords do not match')
    expect(current_path).to eq('/users')
  end

end
