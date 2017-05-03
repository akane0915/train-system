class Stop
  attr_reader(:id, :train_id, :city_id, :time)

  def initialize(attributes)
    @id = attributes.fetch(:id)
    @train_id = attributes.fetch(:train_id)
    @city_id = attributes.fetch(:city_id)
    @time = attributes.fetch(:time)
  end

  def Stop.all
    stops_db = DB.exec("SELECT * FROM stops;")
    stops_array = []
    stops_db.each do |stop|
      id = stop.fetch("id").to_i
      train_id = stop.fetch("train_id").to_i
      city_id = stop.fetch("city_id").to_i
      time = stop.fetch("time")
      stops_array.push(Stop.new({:id => id, :train_id => train_id, :city_id => city_id, :time => time}))
    end
    stops_array
  end

  def ==(another_stop)
    self.id == another_stop.id
  end

  def save
    output = DB.exec("INSERT INTO stops (train_id, city_id, time) VALUES (#{@train_id}, #{@city_id}, '#{@time}') RETURNING id;")
    @id = output.first.fetch("id").to_i
  end

end
