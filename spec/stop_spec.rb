require 'spec_helper'

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
end
