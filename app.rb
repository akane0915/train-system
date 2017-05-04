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
