require './app/models/user'

describe User do

  let!(:user) do
    User.create(email: 'hello@email.com', password: '1234', password_confirmation: '1234')
  end

  it 'authenticates when given a valid email address' do
    authenticated_user = User.authenticate(user.email, user.password)
    expect(authenticated_user).to eq user
  end

  it 'does not authenticate with wrong email' do
    expect(User.authenticate(user.email, '21704e141413')).to be_nil
  end
end
