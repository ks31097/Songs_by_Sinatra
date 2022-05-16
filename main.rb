require 'sinatra'
require './song'
require 'sinatra/reloader'  if development?

set :port, 4567

get '/' do
  erb :home
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
