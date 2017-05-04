class City
  attr_reader :name, :id

  def initialize (attributes)
    @id = attributes.fetch(:id)
    @name = attributes.fetch(:name)
  end

  def City.all
    cities = DB.exec("SELECT * FROM cities")
    cities_array = []
    cities.each do |city|
      name = city.fetch("name")
      id = city.fetch("id").to_i
      cities_array.push(City.new({:id => id, :name => name}))
      # cities.map{|city| City.new({:id => city["id"], :name => city["name"]})}
    end
    cities_array
  end

  def City.find (id)
    found_city = nil
    City.all.each do |city|
      if city.id == id
        found_city = city
      end
    end
    found_city
  end

  def save
    result = DB.exec("INSERT INTO cities (name) VALUES ('#{self.name}') RETURNING id;")
    @id = result.first.fetch('id').to_i
  end

  def ==(another_city)
    self.id == another_city.id
  end

  # stop_data contains any information we need for creating new stops. e.g. train id's stop time and ticket price
  def update(stop_data)
    @name = stop_data.fetch(:name, @name)
    DB.exec("UPDATE cities SET name = '#{@name}' WHERE id = #{@id};")

    stop_data.fetch(:train_ids, []).each do |train_id|
      DB.exec("INSERT INTO stops (city_id, train_id) VALUES (#{@id}, #{train_id});")
    end
  end

  def delete
    DB.exec("DELETE FROM stops where city_id = #{@id};")
    DB.exec("DELETE from cities WHERE id = #{@id};")
  end

  def trains
    city_trains = []
    train_objects = DB.exec("SELECT train_id FROM stops WHERE city_id = #{@id};")
    train_objects.each do |train_object|
      train_id = train_object.fetch('train_id').to_i
      train = DB.exec("SELECT * FROM trains WHERE id = #{train_id}")
      color = train.first.fetch('color')
      city_trains.push(Train.new({:color => color, :id => train_id}))
    end
    city_trains
  end
end
