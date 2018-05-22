class Player
  attr_accessor :destroyer, :submarine, :surviving_ships

  def initialize
    @surviving_ships = 2
  end

  def convert_coordinate(coordinate)
    characters = coordinate.chars
    if characters[0]  == 'a'
      return [0, characters[1].to_i - 1]
    elsif characters[0] == 'b'
      return [1, characters[1].to_i - 1]
    elsif characters[0] == 'c'
      return [2, characters[1].to_i - 1]
    elsif characters[0] == 'd'
      return [3, characters[1].to_i - 1]
    end
  end

  def split_coordinates(coordinates_string)
    coordinates_array = coordinates_string.split(' ')
    coordinates_array.map! do |coordinate|
      convert_coordinate(coordinate)
    end
  end

  def place_ship(coordinates_string, grid)
    coordinates = split_coordinates(coordinates_string)
    coordinates.each do |coordinate|
      grid[coordinate[0]][coordinate[1]].fill
    end
    Ship.new(coordinates)
  end

  def fire_shot(coordinate, grid, player)
    grid[coordinate[0]][coordinate[1]].take_hit
    if grid[coordinate[0]][coordinate[1]].filled?
      puts determine_damaged_ship(grid, player, coordinate)
    else
      puts 'Your shot missed.'
    end
  end

  def determine_damaged_ship(grid, player, coordinate)
    # binding.pry
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
      print "You SUNK the enemy #{ship.name}!"
    else
      print "You hit an enemy ship!"
    end
  end

end
