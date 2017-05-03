class Train
  attr_reader :color, :id

  def initialize (attributes)
    @id = attributes.fetch(:id)
    @color = attributes.fetch(:color)
  end
end
