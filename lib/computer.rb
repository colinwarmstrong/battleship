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

  def fire_random_shot(grid, player)
    row = rand(4)
    column = rand(4)
    if grid[row][column].hit?
      return fire_random_shot(grid, player)
    end
    grid[row][column].take_hit
    random_shot_message(grid, player, row, column)
  end

  def convert_random_shot_to_string(row, column)
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
    return row_string + column_string
  end

  def random_shot_message(grid, player, row, column)
    random_shot_coordinate = convert_random_shot_to_string(row, column)
    puts "The enemy fired at #{random_shot_coordinate}."
    hit_or_miss(grid, player, row, column)
  end

  def hit_or_miss(grid, player, row, column)
    if grid[row][column].filled?
      determine_damaged_ship(grid, player, row, column)
    else
      'The shot missed.'
    end
  end

  def determine_damaged_ship(grid, player, row, column)
    if player.destroyer.coordinates.include?([row, column])
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
      "The enemy SUNK your #{ship.name}!"
    else
      "The enemy hit your #{ship.name}!"
    end
  end

end
