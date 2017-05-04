require 'sinatra'
require 'sinatra/reloader'
require './lib/train'
require './lib/city'
require './lib/stop'
also_reload('lib/**/*.rb')
require 'pry'
require 'pg'

DB = PG.connect({:dbname => 'train_system_test'})

get '/' do
  @trains = Train.all
  @cities = City.all
  stops = Stop.all
  @timetable = []
  stops.each do |stop|
    @timetable.push(stop.details)
  end
  @timetable.sort_by!{|stop|stop.fetch(:time)}
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

# add trains to city object
patch '/cities/:id' do
  city_id = params.fetch('id').to_i
  @city = City.find(city_id)
  train_ids = params.fetch('train_ids')
  times = params.fetch('times').delete_if{|time| time == ""}
  @city.update({:train_ids => train_ids, :times => times})
  @trains = Train.all
  erb :city_info
end

# add cities to train object
patch '/trains/:id' do
  train_id = params.fetch('id').to_i
  @train = Train.find(train_id)
  city_ids = params.fetch('city_ids')
  times = params.fetch('times').delete_if{|time| time == ""}
  @train.update({:city_ids => city_ids, :times => times})
  @cities = City.all
  erb :train_info
end

delete '/cities/:id' do
  city_id = params.fetch('id').to_i
  City.find(city_id).delete
  @cities = City.all
  erb :cities
end

delete '/trains/:id' do
  train_id = params.fetch('id').to_i
  Train.find(train_id).delete
  @trains = Train.all
  erb :trains
end
