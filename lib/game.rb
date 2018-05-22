require './lib/player.rb'
require './lib/computer.rb'
require './lib/board.rb'

class Game
  attr_reader :player, :computer, :player_board, :computer_board, :turns, :start_time

  def initialize
    @player = Player.new
    @computer = Computer.new
    @player_board = Board.new
    @computer_board = Board.new
    @turns = 0
    @start_time = 0
  end

  def intro
    print `clear`
    puts "Welcome to BATTLESHIP\n\n"
    start_game
  end

  def start_game
    puts 'Would you like to (p)lay, read the (i)nstructions, or (q)uit?'
    start_game_choice = gets_input
    start_game_flow(start_game_choice)
  end

  def gets_input
    print '> '
    gets.strip.downcase
  end

  def start_game_flow(start_game_choice)
    if start_game_choice == 'p' || start_game_choice == 'play'
      computer_ship_placement
    elsif start_game_choice = 'i' || start_game_choice == 'instructions'
      instructions
    elsif start_game_choice == 'q' || start_game_choice == 'quit'
      quit
    else
      puts 'Invalid choice. Try again.'
      start_game
    end
  end

  def instructions
    puts 'Here are the instructions.'
  end

  def quit
    print `clear`
    puts 'Goodbye.'
    exit
  end

  def computer_ship_placement
    @computer.destroyer = @computer.ship_orientation(2, @computer_board.grid)
    @player.submarine = @computer.ship_orientation(3, @computer_board.grid)
    puts "The enemy has placed their two ships on the grid, now place your's."
    puts "The grid has A1 at the top left and D4 at the bottom right.\n\n"
    player_destoyer_placement
  end

  def player_destroyer_placement
    puts 'Enter the coordinates for your two unit destroyer:'
    coordinates = get_input
    verify_destroyer(coordaintes, @player_board.grid)
    @player.destroyer = @player.place_ship(coordinates, @player_board.grid)
    puts "\n"
    player_submarine_placement
  end

  def player_submarine_placement
    'Enter the coordinates for your three unit submarine:'
    coordinates = get_input
    verify_submarine(coordinates, @player_board.grid)
    @player.destroyer = @player.place_ship(coordinates, @player_board.grid)
    begin_main_game_phase
  end

  def begin_main_game_phase
    puts 'Here is your map:'
    @player_board.display_player_grid
    wait_for_enter
    print `clear`
    @start_time = Time.new
    next_turn
  end

  def next_turn
    @turns += 1
    @player_board.display_both_grids(@computer_board.grid, @player_board.grid, @turns)
    player_shot_sequence
  end

  def player_shot_sequence
    puts 'Select a coordinate to fire on: '
    coordinate = get_input.delete(' ')
    verify_shot(coordinate)
    @player.fire_shot(coordinate, @computer_board.grid, @computer)
    display_enemy_map
  end

  def display_enemy_map
    puts 'Here is the updated enemy map:'
    @computer_board.display_cpu_grid
    wait_for_enter
    puts '-' * 28
    player_win?
    computer_shot_sequence
  end

  def computer_shot_sequence
    @computer.fire_random_shot(@player_board.grid, @player)
    display_player_map
  end

  def display_player_map
    puts 'Here is your updated map:'
    @player_board.display_player_grid
    wait_for_enter
    computer_win?
    print `clear`
    next_turn
  end

  def player_win?
    player_win_sequence if @computer.surviving_ships == 0
  end

  def computer_win?
    computer_win_sequence if @player.surviving_ships == 0
  end

  def convert_individual_coordinate(coordinate)
    characters = coordinate.chars
    if characters[0]  == 'a'
      return [0, characters[1].to_i - 1]
    elsif characters[0] == 'b'
      return [1, characters[1].to_i - 1]
    elsif characters[0] == 'c'
      return [2, characters[1].to_i - 1]
    elsif characters[0] == 'd'
      return [3, characters[1].to_i - 1]
    else
      return [4, 4]
    end
  end

  def convert_coordinates(coordinates_string)
    coordinates_array = coordinates_string.split(' ')
    coordinates_array.map! do |coordinate|
      convert_individual_coordinate(coordinate)
    end
  end

  def verify_destroyer(coordinates, grid)
    coord_array = convert_coordinates(coordinates)
    verify_given_two_destroyer_coordinates(coordinates, grid)
    verify_given_correct_destroyer_coordinates(coord_array, grid)
    verify_destroyer_horizontal_or_vertical(coord_array, grid)
    verify_destroyer_units_are_adjacent(coord_array, grid)
  end

  def verify_given_two_destroyer_coordinates(coordinates, grid)
    if coordinates.split.length != 2 || coordinates.delete(' ').chars.length != 4
      puts 'Please enter two coordinates seperated by spaces in the form A1. Try agin.'
      return player_destroyer_placement
    end
  end

  def verify_given_correct_destroyer_coordinates(coord_array, grid)
    if !(('a'..'d').include?(coord_array[0])) || !(('a'..'d').include?(coord_array[2]))
      puts 'Make sure your coordinates are between A1 and D4. Try again.'
      return player_destroyer_placement
    elsif !(('1'..'4').include?(coord_array[1])) || !(('1'..'4').include?(coord_array[3]))
      puts 'Make sure your coordinates are between A1 and D4. Try again.'
      return player_destroyer_placement
    end
  end

  def verify_destroyer_horizontal_or_vertical(coord_array, grid)
    if coord_array[0][0] != coord_array[1][0] && coord_array[0][1] != coord_array[1][1]
      puts 'Ships must be placed horizontally or vertically. Try again.'
      return player_destroyer_placement
    end
  end

  def verify_destroyer_units_are_adjacent(coord_array, grid)
    if coord_array[0][0] != coord_array[1][0] - 1 && coord_array[1][0] != coord_array[0][0] - 1 && coord_array[0][1] != coord_array[1][1] - 1 && coord_array[1][1] != coord_array[0][1] - 1
      puts 'All units must be adjacent. Try again.'
      return player_destroyer_placement
    end
  end

  def verify_submarine(coordinates, grid)
    coord_array = split_coordinates(coordinates)
    verify_given_three_sub_coordinates(coordinates, grid)
    verify_given_correct_sub_coordinates(coord_array, grid)
    verify_sub_horizontal_or_vertical(coord_array, grid)
    verify_sub_units_are_adjacent(coord_array, grid)
    verify_sub_units_are_unoccupied(coord_array, grid)
  end

  def verify_given_three_sub_coordinates(coordinates, grid)
    if coordinates.split.length != 3 || coordinates.delete(' ').chars.length != 6
      puts 'Please enter three coordinates seperated by spaces in the form A1. Try agin.'
      return player_submarine_placement
    end
  end

  def verify_given_correct_sub_coordinates(coord_array, grid)
    if !(('a'..'d').include?(coord_array[0])) || !(('a'..'d').include?(coord_array[2])) || !(('a'..'d').include?(coord_array[4]))
      puts 'Make sure your coordinates are between A1 and D4. Try again.'
      return player_submarine_placement
    elsif !(('1'..'4').include?(coord_array[1])) || !(('1'..'4').include?(coord_array[3])) || !(('1'..'4').include?(coord_array[5]))
      puts 'Make sure your coordinates are between A1 and D4. Try again.'
      return player_submarine_placement
    end
  end

  def verify_sub_horizontal_or_vertical(coord_array, grid)
    if (coord_array[0][0] != coord_array[1][0] || coord_array[0][0] != coord_array[2][0] || coord_array[1][0] != coord_array[2][0]) && (coord_array[0][1] != coord_array[1][1] || coord_array[0][1] != coord_array[2][1] || coord_array[1][1] != coord_array[2][1])
      puts 'Ships must be placed horizontally or vertically. Try again.'
      return player_submarine_placement
    end
  end

  def verify_sub_units_are_adjacent(coord_array, grid)
    if ((coord_array[0][0] - coord_array[1][0]).abs > 1 || (coord_array[0][0] - coord_array[2][0]).abs > 2 || (coord_array[1][0] - coord_array[2][0]).abs > 2) || ((coord_array[0][1] - coord_array[1][1]).abs > 1 || (coord_array[0][1] - coord_array[2][1]).abs > 2 || (coord_array[1][1] - coord_array[2][1]).abs > 2)
      puts 'Make sure your coordinates are consecutive and adjacent. Try again.'
      return player_submarine_placement
    end
  end

  def verify_sub_units_are_unoccupied(coord_array, grid)
    coord_array.each do |coordinate|
      if grid[coordinate[0]][coordinate[1]].filled?
        puts 'Ships cannot overlap. Try again.'
        return player_submarine_placement
      end
    end
  end

end
