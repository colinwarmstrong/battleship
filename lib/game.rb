require './lib/board.rb'
require './lib/computer.rb'
require './lib/player.rb'
require './lib/ship.rb'
require './lib/space.rb'
require './lib/verification.rb'
require 'colorize'
require 'pry'

class Game
  include Verification
  attr_reader :turns, :start_time, :player, :computer, :player_board, :computer_board

  def initialize
    @turns = 0
    @start_time = 0
    @player = Player.new
    @computer = Computer.new
    @player_board = Board.new
    @computer_board = Board.new
  end

  def intro
    print `clear`
    puts "Welcome to BATTLESHIP\n\n"
    start_game
  end

  def start_game
    puts 'Would you like to (p)lay, read the (i)nstructions, or (q)uit?'
    start_game_choice = get_input
    start_game_flow(start_game_choice)
  end

  def start_game_flow(start_game_choice)
    if start_game_choice == 'p' || start_game_choice == 'play'
      computer_ship_placement
    elsif start_game_choice == 'i' || start_game_choice == 'instructions'
      instructions
    elsif start_game_choice == 'q' || start_game_choice == 'quit'
      quit
    else
      puts 'Invalid choice. Try again.'
      start_game
    end
  end

  def wait_for_user_input
    print 'Press ENTER to continue.'
    input = gets.chomp.downcase
    if input == 'quit'
      quit
    else
      return
    end
  end

  def computer_ship_placement
    @computer.destroyer = @computer.ship_orientation(2, @computer_board.grid)
    @computer.submarine = @computer.ship_orientation(3, @computer_board.grid)
    puts "The enemy has placed their two ships on the grid, now place your's."
    puts "The grid has A1 at the top left and D4 at the bottom right.\n\n"
    player_destroyer_placement
  end

  def player_destroyer_placement
    puts 'Enter the coordinates for your two unit destroyer:'
    coordinates = get_input
    verify_destroyer(coordinates)
    @player.destroyer = @player.place_ship(convert_coordinates(coordinates), @player_board.grid)
    puts "\n"
    player_submarine_placement
  end

  def player_submarine_placement
    puts 'Enter the coordinates for your three unit submarine:'
    coordinates = get_input
    verify_submarine(coordinates, @player_board.grid)
    @player.submarine = @player.place_ship(convert_coordinates(coordinates), @player_board.grid)
    begin_main_game_phase
  end

  def begin_main_game_phase
    puts 'Here is your map:'
    @player_board.display_player_grid
    wait_for_user_input
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
    puts verify_shot(coordinate)
    puts @player.fire_shot(convert_coordinates(coordinate).flatten!, @computer_board.grid, @computer)
    display_enemy_map
  end

  def display_enemy_map
    puts 'Here is the updated enemy map:'
    @computer_board.display_cpu_grid
    wait_for_user_input
    puts '-' * 28
    player_win?
    computer_shot_sequence
  end

  def computer_shot_sequence
    puts @computer.fire_random_shot(@player_board.grid, @player)
    display_player_map
  end

  def display_player_map
    puts 'Here is your updated map:'
    @player_board.display_player_grid
    wait_for_user_input
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

  def calculate_game_time(finish_time)
    finish_time - @start_time
  end

  def player_win_sequence
    game_time = calculate_game_time(Time.new)
    puts 'Congrats! You won the game in'
    puts "#{@turns} turns over #{(game_time/60).to_i} min #{(game_time % 60).to_i} sec!\n\n"
    end_game
  end

  def computer_win_sequence
    game_time = calculate_game_time(Time.new)
    puts '-' * 28
    puts "You lost in #{@turns} turns over #{(game_time/60).to_i} min #{(game_time % 60).to_i} sec."
    puts "Better luck next time.\n\n"
    end_game
  end

  def end_game
    puts 'Would you like to (p)lay again or (q)uit?'
    end_game_choice = get_input
    end_game_flow(end_game_choice)
  end

  def end_game_flow(end_game_choice)
    if end_game_choice == 'p'  || end_game_choice == 'play'
      print `clear`
      Game.new.computer_ship_placement
    elsif end_game_choice == 'q' || end_game_choice == 'quit'
      quit
    else
      puts 'Invalid choice. Try again.'
      end_game
    end
  end

  def get_input
    print '> '
    gets.strip.downcase
  end

  def quit
    print `clear`
    puts 'Goodbye.'
    exit
  end

  def instructions
    puts 'Here are the instructions.'
    start_game
  end

end
