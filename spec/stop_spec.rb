require 'spec_helper'

# TODO: all method
# TODO: save to db method
# TODO: edit method
# TODO: delete method
# TODO: retrieve all trains by city
# TODO: retrieve all cities by trains

describe Stop do
  describe '#==' do
    it 'will return true if two stops have the same id' do
      test_train = Train.new({:color => 'blue', :id => nil})
      test_city = City.new({:name => 'portland', :id => nil})
      stop1 = Stop.new({:id => nil, :train_id => test_train.id, :city_id => test_city.id, :time => '08:00:00'})
      stop2 = Stop.new({:id => nil, :train_id => test_train.id, :city_id => test_city.id, :time => '08:00:00'})
      expect(stop1 == stop2).to eq true
    end
  end

  describe '#id' do
    it 'will return the id of a specific stop' do
      test_stop = Stop.new({:id => nil, :train_id => nil, :city_id => nil, :time => '08:00:00'})
      expect(test_stop.id).to eq nil
    end
  end

  describe '#train_id' do
    it 'will return the train id of a specific stop' do
      test_train = Train.new({:color => 'blue', :id => nil})
      test_stop = Stop.new({:id => nil, :train_id => test_train.id, :city_id => nil, :time => '08:00:00'})
      expect(test_stop.train_id).to eq test_train.id
    end
  end

  describe '#city_id' do
    it 'will return the city id of a specific stop' do
      test_city = City.new({:name => 'portland', :id => nil})
      test_stop = Stop.new({:id => nil, :train_id => nil, :city_id => test_city.id, :time => '08:00:00'})
      expect(test_stop.city_id).to eq test_city.id
    end
  end

  describe '#time' do
    it 'will return the time of a specific stop' do
      test_stop = Stop.new({:id => nil, :train_id => nil, :city_id => nil, :time => '08:00:00'})
      expect(test_stop.time).to eq '08:00:00'
    end
  end

  describe '.all' do
    it 'will return an empty list if no stops exist' do
      expect(Stop.all).to eq []
    end
    it 'will return a list of all stops' do
      test_train = Train.new({:color => 'blue', :id => nil})
      test_train.save
      test_city = City.new({:name => 'portland', :id => nil})
      test_city.save
      test_stop = Stop.new({:id => nil, :train_id => test_train.id, :city_id => test_city.id, :time => '08:00:00'})
      test_stop.save
      expect(Stop.all).to eq [test_stop]
    end
  end

  describe '#save' do
    it 'will save a given stop to the database' do
      test_train = Train.new({:color => 'blue', :id => nil})
      test_train.save
      test_city = City.new({:name => 'portland', :id => nil})
      test_city.save
      test_stop = Stop.new({:id => nil, :train_id => test_train.id, :city_id => test_city.id, :time => '08:00:00'})
      test_stop.save
      expect(Stop.all).to eq [test_stop]
    end
  end

end
