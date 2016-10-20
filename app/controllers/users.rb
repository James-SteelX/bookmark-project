class BookmarkManager < Sinatra::Base

  get '/users' do
    @user = User.new
    erb :'users/sign_up'
  end

  get '/users/sign_in' do
    erb :'/users/sign_in'
  end

  post '/users/sign_in' do
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect '/links'
    else
      flash.now[:errors] = ['The emails or password is incorrect']
      erb :'users/sign_in'
    end
  end

  delete '/users/sign_in' do
    session[:user_id] = nil
    flash.keep[:notice] = 'Goodbye!'
    redirect '/links'
  end

  post '/users' do
    @user = User.new(email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])
    if @user.save
      session[:user_id] = @user.id
      redirect to('/links')
    else
      flash.now[:errors] = @user.errors.full_messages
      erb :'/users/sign_up'
    end
  end

  get '/users/recovery' do
    erb :'/users/recovery'
  end

  post '/users/recovery' do
    user = User.first(email: params[:email])
    if user
      user.generate_token
    end
    erb :'/users/acknowledgement'
  end

  get '/users/reset_password' do
    'Your token is invalid'
  end

end
