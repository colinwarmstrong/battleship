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

end
