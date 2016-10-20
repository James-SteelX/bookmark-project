require './app/models/user'

describe User do

  let!(:user) do
    User.create(email: 'hello@email.com', password: '1234', password_confirmation: '1234')
  end

  it 'authenticates when given a valid email address and password' do
    authenticated_user = User.authenticate(user.email, user.password)
    expect(authenticated_user).to eq user
  end

  it 'does not authenticate with wrong password' do
    expect(User.authenticate(user.email, '21704e141413')).to be_nil
  end

  it "saves a password recovery token when we generate a token" do
   expect{user.generate_token}.to change{user.password_token}
  end

  it 'saves a password recovery token time when we generate a token' do
    Timecop.freeze do
      user.generate_token
      expect(user.password_token_time).to eq Time.now 
    end
  end

end
