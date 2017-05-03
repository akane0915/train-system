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

  def save
    result = DB.exec("INSERT INTO trains (color) VALUES ('#{self.color}') RETURNING id;")
    @id = result.first.fetch('id').to_i
  end

  def ==(another_train)
    self.id == another_train.id
  end

  def update(attributes)
    @color = attributes.fetch(:color)
    @id = self.id
    DB.exec("UPDATE trains SET color = '#{@color}' WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE from trains WHERE id = #{@id};")
  end
end
