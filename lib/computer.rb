require './lib/ship.rb'

class Computer

  def initialize
    @surviving_ships = 2
  end

  def ship_orientation(ship_length, grid)
    orientation = rand(2)
    if orientation == 0
      horizontal_placement(ship_length, grid)
    else
      vertical_placement(ship_length, grid)
    end
  end

  def horizontal_placement(ship_length, grid)
    row = rand(4)
    column = rand(5 - ship_length)
    horizontal_placement_validation(ship_length, grid, row, column)
    ship_length.times { |index| grid[row][column + index].fill }
    create_horizontal_ship(ship_length, row, column)
  end

  def horizontal_placement_validation(ship_length, grid, row, column)
    grid[row][column..(column + ship_length)].each do |space|
      if space.filled?
        return horizontal_placement(ship_length, grid)
      end
    end
  end

  def create_horizontal_ship(ship_length, row, column)
    coordinates = []
    ship_length.times do |index|
      coordinates << [row, column + index]
    end
    Ship.new(coordinates)
  end

  def vertical_placement(ship_length, grid)
    row = rand(5 - ship_length)
    column = rand(4)
    vertical_placement_validation(ship_length, grid, row, column)
    ship_length.times { |index| grid[row + index][row][column] }
    create_vertical_ship(ship_length, row, column)
  end

  def vertical_placement_validation(ship_length, grid, row, column)
    grid.tanspose[column][row..(row + ship_length)].each do |space|
      if space.filled?
        return vertical_placement(ship_length, grid)
      end
    end
  end

  def create_vertical_ship
    coordinates = []
    ship_length.times do |index|
      coordinates << [row + index, column]
    end
    Ship.new(coordinates)
  end

end
