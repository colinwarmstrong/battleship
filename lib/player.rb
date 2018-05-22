class Player
  attr_accessor :destroyer, :submarine
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

end
