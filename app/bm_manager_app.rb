ENV["RACK_ENV"] ||= "development"
require 'sinatra/base'
require 'sinatra/flash'
require_relative './models/link'
require_relative 'data_mapper_setup'

class BookmarkManager < Sinatra::Base

  enable :sessions
  set :session_secret, 'super secret'
  register Sinatra::Flash

  get '/' do
    'Hello BookmarkManager!'
    redirect '/links'
  end

  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  get '/links/new' do
    erb :'links/new'
  end

  post '/links' do
    link = Link.create(:url => params[:url], :title => params[:title])
    params[:tags].split.each do |tag|
      link.tags << Tag.create(name: tag)
    end
    link.save
    redirect '/links'
  end

  get '/tags/:name' do
    tag = Tag.first(name: params[:name])
    @links = tag ? tag.links : []
    erb :'links/index'
  end

  post '/users' do
    @user = User.new(:email => params[:email], :password => params[:password], :password_confirmation => params[:confirm_password])
    if @user.save
      session[:user_id] = @user.id
      redirect '/links'
    else
      flash.now[:errors] = @user.errors.full_messages
      erb :'users/sign_up'
    end
  end

  get '/sessions/sign_in' do
    erb :'sessions/sign_in'
  end

  post '/sessions/sign_in' do
    redirect 'sessions/sign_in'
  end

  post '/sessions' do
    user = User.authenticate(params[:email], params[:password])
    if user
       session[:user_id] = user.id
      redirect '/links'
    else
      flash.now[:errors] = ['The email or password is incorrect']
      erb :'sessions/sign_in'
    end
  end

  get '/users/sign_up' do
    @user = User.new
    erb :'users/sign_up'
  end

  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end

    def login
      user = User.authenticate(params[:email], params[:password])
      if user
         session[:user_id] = user.id
        redirect '/links'
      else
        flash.now[:errors] = ['The email or password is incorrect']
        erb :'sessions/sign_in'
      end
    end
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
