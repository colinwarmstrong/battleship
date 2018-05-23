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

  def fire_shot(coordinate, grid, player)
    grid[coordinate[0]][coordinate[1]].take_hit
    if grid[coordinate[0]][coordinate[1]].filled?
      determine_damaged_ship(coordinate, grid, player)
    else
      'Your shot missed.'
    end
  end

  def determine_damaged_ship(coordinate, grid, player)
    if player.destroyer.coordinates.include?(coordinate)
      player.destroyer.take_damage
      hit_message(player.destroyer, player)
    else
      player.submarine.take_damage
      hit_message(player.submarine, player)
    end
  end

  def hit_message(ship, player)
    if ship.sunk?
      player.surviving_ships -= 1
      "You SUNK the enemy #{ship.name}!"
    else
      'You hit an enemy ship!'
    end
  end

end
