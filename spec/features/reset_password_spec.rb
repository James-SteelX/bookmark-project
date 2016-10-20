feature 'password reset' do

  before do
    create_user('joe@email.com', '1234','1234')
    Capybara.reset!
  end
  let(:user) { User.first }

  scenario 'token only lasts one hour' do
    recover_password
    Timecop.travel(60 * 60 * 60) do
      visit("/users/reset_password?token=#{user.password_token}")
      expect(page).to have_content "Your token is invalid"
    end

    scenario 'it asks for your new password when your token is valid' do
    recover_password
    visit("/users/reset_password?token=#{user.password_token}")
    expect(page).to have_content("Please enter your new password")
   end
  end

end
