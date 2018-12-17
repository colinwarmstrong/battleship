class Computer
  attr_accessor :destroyer, :submarine, :surviving_ships

  def initialize
    @surviving_ships = 2
  end

  def place_random_ship(ship_length, grid)
    orientation = rand(2)
    if orientation.zero?
      horizontal_placement(ship_length, grid)
    else
      vertical_placement(ship_length, grid)
    end
  end

  def horizontal_placement(ship_length, grid)
    row = rand(4)
    column = rand(5 - ship_length)
    grid[row][column..(column + ship_length)].each do |space|
      return place_random_ship(ship_length, grid) if space.filled?
    end
    ship_length.times { |index| grid[row][column + index].fill }
    create_horizontal_ship(ship_length, row, column)
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
    grid.transpose[column][row..(row + ship_length)].each do |space|
      return place_random_ship(ship_length, grid) if space.filled?
    end
    ship_length.times { |index| grid[row + index][column].fill }
    create_vertical_ship(ship_length, row, column)
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
    return fire_random_shot(grid, player) if grid[row][column].hit?
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
    row_string + column_string
  end

  def random_shot_message(grid, player, row, column)
    random_shot_coordinate = convert_random_shot_to_string(row, column)
    puts "The enemy fired at #{random_shot_coordinate}."
    hit_or_miss(grid, player, row, column)
  end

  def hit_or_miss(grid, player, row, column)
    if grid[row][column].filled?
      determine_damaged_ship(player, row, column)
    else
      'The shot missed.'
    end
  end

  def determine_damaged_ship(player, row, column)
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
