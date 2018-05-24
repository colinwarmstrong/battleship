class Player
  attr_accessor :destroyer, :submarine, :surviving_ships

  def initialize
    @surviving_ships = 2
  end

  def place_ship(coordinates, grid)
    coordinates.each do |coordinate|
      grid[coordinate[0]][coordinate[1]].fill
    end
    Ship.new(coordinates)
  end

  def fire_shot(coordinate, grid, computer)
    grid[coordinate[0]][coordinate[1]].take_hit
    if grid[coordinate[0]][coordinate[1]].filled?
      determine_damaged_ship(coordinate, computer)
    else
      'Your shot missed.'
    end
  end

  def determine_damaged_ship(coordinate, computer)
    if computer.destroyer.coordinates.include?(coordinate)
      computer.destroyer.take_damage
      hit_message(computer.destroyer, computer)
    else
      computer.submarine.take_damage
      hit_message(computer.submarine, computer)
    end
  end

  def hit_message(ship, computer)
    if ship.sunk?
      computer.surviving_ships -= 1
      "You SUNK the enemy #{ship.name}!"
    else
      'You hit an enemy ship!'
    end
  end

end
