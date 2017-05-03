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
end
