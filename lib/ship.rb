class Ship

  attr_accessor :coordinates, :hit_points, :ship_length 

  def initialize(coordinates)
    @coordinates = coordinates
    @hit_points = coordinates.length
    @ship_length = coordinates.length
  end

end
