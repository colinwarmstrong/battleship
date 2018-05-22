require './lib/player.rb'
require './lib/computer.rb'
require './lib/board.rb'

class Game

  def initialize
    @player = Player.new
    @computer = Computer.new
    @player_board = Board.new
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
  end

end
