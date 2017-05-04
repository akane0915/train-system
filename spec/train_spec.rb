require "spec_helper"

describe Train do
  describe '#color' do
    it 'returns the color of a specific train' do
      test_train = Train.new({:color => 'blue', :id => nil})
      expect(test_train.color).to eq 'blue'
    end
  end

  describe '#id' do
    it 'returns the unique id of a specific train' do
      test_train = Train.new({:color => 'blue', :id => nil})
      expect(test_train.id).to eq nil
    end
  end

  describe '.all' do
    it 'returns an empty array if there are no trains' do
      expect(Train.all).to eq []
    end
    it 'returns a list of all trains' do
      test_train = Train.new({:color => 'blue', :id => nil})
      test_train.save
      expect(Train.all).to eq [test_train]
    end
  end

  describe '#save' do
    it 'saves a train to the database' do
      test_train = Train.new({:color => 'blue', :id => nil})
      test_train.save
      expect(Train.all).to eq [test_train]
    end
  end

  describe '#==' do
    it 'will return true if two trains have the same id' do
      train1 = Train.new({:color => 'blue', :id => nil})
      train2 = Train.new({:color => 'blue', :id => nil})
      expect(train1 == train2).to eq true
    end
  end

  describe '#update' do
    it 'updates the cities that each train stops at or the train color' do
      city1 = City.new({:name => 'portland', :id => nil})
      city1.save
      city2 = City.new({:name => 'seattle', :id => nil})
      city2.save
      test_train = Train.new({:color => 'blue', :id => nil})
      test_train.save
      test_train.update({:city_ids => [city1.id, city2.id]})
      expect(test_train.cities).to eq [city1, city2]
    end
  end

  describe '#delete' do
    it 'deletes a train' do
      train1 = Train.new({:color => 'blue', :id => nil})
      train1.save
      train2 = Train.new({:color => 'red', :id => nil})
      train2.save
      train1.delete
      expect(Train.all).to eq [train2]
    end
  end

  describe '.find' do
    it 'finds a train by its id' do
      test_train = Train.new({:color => 'blue', :id => nil})
      test_train.save
      expect(Train.find(test_train.id)).to eq test_train
    end
  end

  describe '#cities' do
    it 'returns the cities that a particular train stops at' do
      city1 = City.new({:name => 'portland', :id => nil})
      city1.save
      city2 = City.new({:name => 'seattle', :id => nil})
      city2.save
      test_train = Train.new({:color => 'blue', :id => nil})
      test_train.save
      test_train.update({:city_ids => [city1.id, city2.id]})
      expect(test_train.cities).to eq [city1, city2]
    end
  end
end
