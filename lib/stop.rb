class Stop
  attr_reader(:id, :train_id, :city_id, :time)

  def initialize(attributes)
    @id = attributes.fetch(:id)
    @train_id = attributes.fetch(:train_id)
    @city_id = attributes.fetch(:city_id)
    @time = attributes.fetch(:time)
  end

  def ==(another_stop)
    self.id == another_stop.id
  end
end
