require 'sinatra'
require './song'
require 'sinatra/reloader'  if development?

set :port, 4567

configure do
  enable :sessions
  set :username, 'frank'
  set :password, 'sinatra'
end

get '/' do
  erb :home
end

get '/login' do
  erb :login
end

post '/login' do
  if params[:username] == settings.username && params[:password] == settings.password
    session[:admin] = true
    redirect to('/songs')
  else
    erb :login
  end
end

get '/logout' do
  session.clear
  redirect to('/login')
end

get '/about' do
  @title = 'All About This Website'
  erb :about
end

get '/contact' do
  @title = 'Our Contacts'
  erb :contact
end

not_found do
  erb :not_found
end
