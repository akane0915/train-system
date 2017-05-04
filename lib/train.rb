class Train
  attr_reader :color, :id

  def initialize (attributes)
    @id = attributes.fetch(:id)
    @color = attributes.fetch(:color)
  end

  def Train.all
    trains = DB.exec("SELECT * FROM trains")
    trains_array = []
    trains.each do |train|
      color = train.fetch("color")
      id = train.fetch("id").to_i
      trains_array.push(Train.new({:id => id, :color => color}))
      # trains.map{|train| Train.new({:id => train["id"], :color => train["color"]})}
    end
    trains_array
  end

  def Train.find (id)
    found_train = nil
    Train.all.each do |train|
      if train.id == id
        found_train = train
      end
    end
    found_train
  end

  def save
    result = DB.exec("INSERT INTO trains (color) VALUES ('#{self.color}') RETURNING id;")
    @id = result.first.fetch('id').to_i
  end

  def ==(another_train)
    self.id == another_train.id
  end

  # stop_data contains any information we need for creating new stops. e.g. city id's stop time and ticket price
  def update(stop_data)
    @color = stop_data.fetch(:color, @color)
    DB.exec("UPDATE trains SET color = '#{@color}' WHERE id = #{@id};")
    times = stop_data.fetch(:times, [])
    stop_data.fetch(:city_ids, []).each_with_index do |city_id, index|
      DB.exec("INSERT INTO stops (train_id, city_id, time) VALUES (#{@id}, #{city_id}, '#{times[index] ?  times[index] : "00:00:00"}');")
    end
  end

  def delete
    DB.exec("DELETE FROM stops where train_id = #{@id};")
    DB.exec("DELETE from trains WHERE id = #{@id};")
  end

  def cities
    train_cities =[]
    city_objects = DB.exec("SELECT city_id FROM stops WHERE train_id = #{@id};")
    city_objects.each do |city_object|
      city_id = city_object.fetch('city_id').to_i
      city = DB.exec("SELECT * FROM cities WHERE id = #{city_id};")
      name = city.first.fetch('name')
      train_cities.push(City.new({:name => name, :id => city_id}))
    end
    train_cities
  end
end
