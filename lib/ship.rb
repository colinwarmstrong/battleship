class Ship
  attr_reader :coordinates

  def initialize(coordinates)
    @coordinates = coordinates
    @hit_points = coordinates.length
    @ship_length = coordinates.length
  end

  def take_damage
    @hit_points -= 1
  end

  def sunk?
    if @hit_points == 0
      true
    else
      false
    end
  end

  def name
    if @ship_length == 2
      'destroyer'
    else
      'submarine'
    end
  end

end
