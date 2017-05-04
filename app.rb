require 'sinatra'
require 'sinatra/reloader'
require './lib/train'
require './lib/city'
also_reload('lib/**/*.rb')
require 'pry'
require 'pg'

DB = PG.connect({:dbname => 'train_system'})

get '/' do
  @trains = Train.all
  @cities = City.all
  erb :index
end

get '/trains' do
  @trains = Train.all
  erb :trains
end

get '/cities' do
  @cities = City.all
  erb :cities
end

post '/trains' do
  color = params.fetch('color')
  Train.new({:color => color, :id => nil}).save
  @trains = Train.all
  erb :trains
end

post '/cities' do
  name = params.fetch('name')
  City.new({:name => name, :id => nil}).save
  @cities = City.all
  erb :cities
end

get '/trains/:id' do
  @train = Train.find(params.fetch('id').to_i)
  @cities = City.all
  erb :train_info
end

get '/cities/:id' do
  @city = City.find(params.fetch('id').to_i)
  @trains = Train.all
  erb :city_info
end
# 
# patch '/trains/:id' do
#   train_id = params.fetch("id").to_i()
#   @train = Train.find(train_id)
#   city_ids = params.fetch("city_ids")
#   @actor.update({:movie_ids => movie_ids})
#   @movies = Movie.all()
#   erb(:actor_info)
# end
