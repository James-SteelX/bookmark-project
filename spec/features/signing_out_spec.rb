feature 'Signing out' do
  before do
    create_user('joe@email.com', '12345', '12345')
  end

  scenario 'user can sign out' do
    sign_in(email: 'joe@email.com', password: '12345')
    click_button 'Sign Out'
    expect(page).to have_content('Goodbye!')
    expect(current_path).to eq '/links'
    expect(page).not_to have_content('Welcome, joe@email.com')
  end
end
