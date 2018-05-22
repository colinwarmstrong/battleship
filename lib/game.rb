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
  end

  def verify_destroyer(coordinates, grid)
    coord_array = split_coordinates(coordinates)
    verify_given_two_coordinates(coordinates, grid)
    verify_given_correct_coordinates(coord_array, grid)
    verify_horizontal_or_vertical(coord_array, grid)
    verify_units_are_adjacent(coord_array, grid)
  end

  def verify_given_two_coordinates(coordinates, grid)
    if coordinates.split.length != 2 || coordinates.delete(' ').chars.length != 4
      puts 'Please enter two coordinates seperated by spaces in the form A1. Try agin.'
      return player_destroyer_placement
    end
  end

  def verify_given_correct_coordinates(coord_array, grid)
    coord_array = coordinates.delete(' ').chars
    if !(('a'..'d').include?(coord_array[0])) || !(('a'..'d').include?(coord_array[2]))
      puts 'Make sure your coordinates are between A1 and D4. Try again.'
      return player_destroyer_placement
    elsif !(('1'..'4').include?(coord_array[1])) || !(('1'..'4').include?(coord_array[3]))
      puts 'Make sure your coordinates are between A1 and D4. Try again.'
      return player_destroyer_placement
    end
  end

  def verify_horizontal_or_vertical(coord_array, grid)
    if coord_array[0][0] != coord_array[1][0] && coord_array[0][1] != coord_array[1][1]
      puts 'Ships must be placed horizontally or vertically. Try again.'
      return player_destroyer_placement
    end
  end

  def verify_units_are_adjacent(coord_array, grid)
    if coord_array[0][0] != coord_array[1][0] - 1 && coord_array[1][0] != coord_array[0][0] - 1 && coord_array[0][1] != coord_array[1][1] - 1 && coord_array[1][1] != coord_array[0][1] - 1
      puts 'All units must be adjacent. Try again.'
      return player_destroyer_placement
    end
  end

end
