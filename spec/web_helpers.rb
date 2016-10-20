module SessionHelpers

	def create_user(email, password, password_confirmation)
		visit('/users')

		fill_in :email, with: email
		fill_in :password, with: password
		fill_in :password_confirmation, with: password_confirmation
		click_button('Sign Up')
	end

	def sign_in(email:, password:)
		visit('users/sign_in')
		fill_in :email, with: email
		fill_in :password, with: password
		click_button 'Sign in'
	end

end
