require 'spec_helper'
require './app/models/user'
require_relative 'web_helper'

feature 'Users signs in to website' do

  before do
    sign_up
  end

  scenario 'user signs in' do
    visit('sessions/sign_in')
    fill_in :email,   with: 'joe@email.com'
    fill_in :password, with: 'abc123'
    click_button 'Sign in'
    expect(page).to have_content 'Welcome joe@email.com'
  end
end
