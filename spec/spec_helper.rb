require 'rspec'
require 'pg'
require 'train'
require 'city'
require 'stop'

DB = PG.connect({:dbname => "train_system_test"})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM trains *;")
    DB.exec("DELETE FROM cities *;")
    DB.exec("DELETE FROM stops *;")
  end
end
