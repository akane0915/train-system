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

  def update(attributes)
    @name = attributes.fetch(:name)
    @id = self.id
    DB.exec("UPDATE cities SET name = '#{@name}' WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE from cities WHERE id = #{@id};")
  end
end
