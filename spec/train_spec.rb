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
  end

  describe '#save' do
    it 'saves a train to the database' do
      test_train = Train.new({:color => 'blue', :id => nil})
      test_train.save
      expect(Train.all).to eq [test_train]
    end
  end

  describe '#==' do
    it 'is the same train if it has the same color and id' do
      train1 = Train.new({:color => 'blue', :id => nil})
      train2 = Train.new({:color => 'blue', :id => nil})
      expect(train1 == train2).to eq true
    end
  end

  describe '#update' do
    it 'updates the color of a train' do
      test_train = Train.new({:color => 'blue', :id => nil})
      test_train.save
      test_train.update({:color => 'red'})
      expect(test_train.color).to eq 'red'
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
end
