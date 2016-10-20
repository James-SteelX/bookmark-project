feature 'Resetting Password' do

  scenario 'When i forget my password there is a link to reset it' do
    visit '/users/sign_in'
    click_button 'Password recovery'
    expect(page).to have_content("Please enter your email address")
   end

   scenario 'when I enter my email I am told to check my inbox' do
     recover_password
     expect(page).to have_content "Thanks, please check your inbox for the link."
   end
  end
