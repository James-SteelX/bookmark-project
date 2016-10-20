ENV["RACK_ENV"] ||= "development"

require 'sinatra/base'
require 'sinatra/flash'
require_relative 'data_mapper_setup'

class BookmarkManager < Sinatra::Base

  use Rack::MethodOverride

  register Sinatra::Flash

  enable :sessions
  set :session_secret, 'super secret'

  get '/' do
    "welcome to the bookmark manager"
  end

  get '/links' do
    @links = Link.all
    erb :'/links/index'
  end

  post '/links' do
    link = Link.new(url: params[:url], title: params[:title])
    params[:tags].split.each do |tag|
      link.tags << Tag.create(name: tag)
    end
    link.save
    redirect '/links'
  end

  get '/links/new' do
    erb :'/links/new'
  end

  get '/tags/:name' do
    tag = Tag.all(name: params[:name])
    @links = tag ? tag.links : []
    erb :'links/index'
  end

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

  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
