require 'dm-core'
require 'dm-migrations'

configure :development do
  DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/development.db")
end

class Song
  include DataMapper::Resource
  property :id, Serial
  property :title, String
  property :lyrics, Text
  property :length, Integer
  property :released_on, Date
end

DataMapper.finalize

get '/songs' do
  @songs = Song.all
  erb :songs
end

get '/songs/new' do
  halt(redirect to('/login')) unless session[:admin]
  @song = Song.new
  erb :new_song
end

get '/songs/:id' do
  @song = Song.get(params[:id])
  erb :show_song
end

get '/songs/:id/edit' do
  halt(401, 'Not Authorized') unless session[:admin]
  @song = Song.get(params[:id])
  erb :edit_song
end

post '/songs' do
  halt(401, 'Not Authorized') unless session[:admin]
  song = Song.create(params[:song])
  redirect to("/songs/#{song.id}")
end

put '/songs/:id' do
  song = Song.get(params[:id])
  song.update(params[:song])
  redirect to("/songs/#{song.id}")
end

delete '/songs/:id' do
  halt(401, 'Not Authorized') unless session[:admin]
  Song.get(params[:id]).destroy
  redirect to('/songs')
end
