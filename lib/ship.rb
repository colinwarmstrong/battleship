class Ship

  def initialize(coordinates)
    @coordinates = coordinates
    @hit_points = coordinates.length
    @ship_length = coordinates.length
  end

end
