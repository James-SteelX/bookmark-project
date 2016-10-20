feature 'signing in' do
  before do
    create_user('joe@email.com', '12345', '12345')
  end

  scenario 'A user signs in' do
    visit('users/sign_in')
    fill_in :email, with: 'joe@email.com'
    fill_in :password, with: '12345'
    click_button 'Sign in'
    expect(page).to have_content 'Welcome, joe@email.com'
  end
end
