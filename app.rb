require 'sinatra'
require 'sinatra/reloader'
require './lib/train'
require './lib/city'
require './lib/stop'
require 'pry'

also_reload('lib/**/*.rb')

get('/') do
  erb(:index)
end
