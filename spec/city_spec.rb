require "spec_helper"

describe City do
  describe '#name' do
    it 'returns the name of a specific city' do
      test_city = City.new({:name => 'portland', :id => nil})
      expect(test_city.name).to eq 'portland'
    end
  end

  describe '#id' do
    it 'returns the unique id of a specific city' do
      test_city = City.new({:name => 'portland', :id => nil})
      expect(test_city.id).to eq nil
    end
  end

  describe '.all' do
    it 'returns an empty array if there are no cities' do
      expect(City.all).to eq []
    end
    it 'returns a list of all cities' do
      test_city = City.new({:name => 'portland', :id => nil})
      test_city.save
      expect(City.all).to eq [test_city]
    end
  end

  describe '#save' do
    it 'saves a city to the database' do
      test_city = City.new({:name => 'portland', :id => nil})
      test_city.save
      expect(City.all).to eq [test_city]
    end
  end

  describe '#==' do
    it 'will return true if two cities have the same id' do
      city1 = City.new({:name => 'portland', :id => nil})
      city2 = City.new({:name => 'portland', :id => nil})
      expect(city1 == city2).to eq true
    end
  end

# Add another test for update method to change city name
  describe '#update' do
    it 'updates the trains that stop at a city or the city name' do
      test_city = City.new({:name => 'portland', :id => nil})
      test_city.save
      train1 = Train.new({:color => 'blue', :id => nil})
      train1.save
      train2 = Train.new({:color => 'red', :id => nil})
      train2.save
      test_city.update({:train_ids => [train1.id, train2.id]})
      expect(test_city.trains).to eq [train1, train2]
    end
  end

  describe '#delete' do
    it 'deletes a city' do
      city1 = City.new({:name => 'portland', :id => nil})
      city1.save
      city2 = City.new({:name => 'seattle', :id => nil})
      city2.save
      city1.delete
      expect(City.all).to eq [city2]
    end
  end

  describe '.find' do
    it 'finds a city by its id' do
      test_city = City.new({:name => 'portland', :id => nil})
      test_city.save
      expect(City.find(test_city.id)).to eq test_city
    end
  end

  describe '#trains' do
    it 'returns the trains that stop at this city' do
      test_city = City.new({:name => 'portland', :id => nil})
      test_city.save
      train1 = Train.new({:color => 'blue', :id => nil})
      train1.save
      train2 = Train.new({:color => 'red', :id => nil})
      train2.save
      test_city.update({:train_ids => [train1.id, train2.id]})
      expect(test_city.trains).to eq [train1,train2]
    end
  end
end
