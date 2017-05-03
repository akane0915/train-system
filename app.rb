require 'sinatra'
require 'sinatra/reloader'
require './lib/train'
require './lib/city'
require 'pry'

also_reload('lib/**/*.rb')

get('/') do
  erb(:index)
end
