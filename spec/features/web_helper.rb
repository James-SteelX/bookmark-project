def sign_up
  visit '/users/sign_up'
  expect(page.status_code).to eq(200)
  fill_in :email,   with: 'joe@email.com'
  fill_in :password, with: 'abc123'
  fill_in :confirm_password, with: 'abc123'
  click_button 'Sign up'
end

def bad_sign_up
  visit '/users/sign_up'
  expect(page.status_code).to eq(200)
  fill_in :email,   with: 'joe@email.com'
  fill_in :password, with: 'abc123'
  fill_in :confirm_password, with: 'bad'
  click_button 'Sign up'
end
