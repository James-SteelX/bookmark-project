feature 'Creating users' do
	scenario 'creating a user' do
		create_user('ben@example.com', 'password', 'password')
		initial_length = User.all.length
		create_user('ben@example.com', 'password', 'password')
		expect(User.all.length).to be > initial_length
	end

	scenario 'user provides mismatching passwords' do
		expect { create_user('ben@example.com', 'apples', 'pears') }.not_to change(User, :count)
	  expect(current_path).to eq('/users')
	  expect(page).to have_content 'Password and confirmation password do not match'
	end

	scenario 'user can\'t submit blank email' do
		expect { create_user('', 'pears', 'pears') }.not_to change(User, :count)
		expect(current_path).to eq('/users')
	end

	scenario 'user can\'t submit wrongly formatted email' do
		expect { create_user('bjds`bvbvnjvks.bvk', 'pears', 'pears') }.not_to change(User, :count)
		expect(current_path).to eq('/users')
	end

end
