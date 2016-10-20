feature 'Creating users' do
	scenario 'creating a user' do
		expect { create_user('ben@example.com', 'password', 'password') }.to change(User, :count).by(1)
	end

	scenario 'user provides mismatching passwords' do
		expect { create_user('ben@example.com', 'apples', 'pears') }.not_to change(User, :count)
	  expect(current_path).to eq('/users')
	  expect(page).to have_content 'Password does not match the confirmation'
	end

	scenario 'user can\'t submit blank email' do
		expect { create_user('', 'pears', 'pears') }.not_to change(User, :count)
		expect(current_path).to eq('/users')
	end

	scenario 'user can\'t submit wrongly formatted email' do
		expect { create_user('bjds`bvbvnjvks.bvk', 'pears', 'pears') }.not_to change(User, :count)
		expect(current_path).to eq('/users')
	end

	scenario 'user can not sign up with registered email' do
		create_user('ben@example.com', 'pears', 'pears')
		expect { create_user('ben@example.com', 'pears', 'pears') }.not_to change(User, :count)
		expect(page).to have_content 'Email is already taken'
	end

end
