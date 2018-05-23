class Computer
  attr_accessor :destroyer, :submarine, :surviving_ships

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
    ship_length.times { |index| grid[row + index][column].fill }
    create_vertical_ship(ship_length, row, column)
  end

  def vertical_placement_validation(ship_length, grid, row, column)
    grid.transpose[column][row..(row + ship_length)].each do |space|
      if space.filled?
        return vertical_placement(ship_length, grid)
      end
    end
  end

  def create_vertical_ship(ship_length, row, column)
    coordinates = []
    ship_length.times do |index|
      coordinates << [row + index, column]
    end
    Ship.new(coordinates)
  end

  def fire_random_shot(grid, computer)
    row = rand(4)
    column = rand(4)
    if grid[row][column].hit?
      return fire_random_shot(grid, computer)
    end
    grid[row][column].take_hit
    convert_random_shot_to_string(grid, computer, row, column)
  end

  def convert_random_shot_to_string(grid, computer, row, column)
    column_string = (column + 1).to_s
    if row == 0
      row_string = 'A'
    elsif row == 1
      row_string = 'B'
    elsif row == 2
      row_string = 'C'
    elsif row == 3
      row_string = 'D'
    end
    puts "The enemy fired at #{row_string}#{column_string}."
    hit_or_miss(grid, computer, row, column)
  end

  def hit_or_miss(grid, computer, row, column)
    if grid[row][column].filled?
      determine_damaged_ship(grid, computer, row, column)
    else
      puts 'The shot missed.'
    end
  end

  def determine_damaged_ship(grid, computer, row, column)
    if computer.destroyer.coordinates.include?([row, column])
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
      puts "The enemy SUNK your #{ship.name}!"
    else
      puts "The enemy hit your #{ship.name}!"
    end
  end

end
