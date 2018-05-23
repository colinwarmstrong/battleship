require 'minitest/autorun'
require 'minitest/pride'
require './lib/player.rb'
require './lib/ship.rb'
require './lib/game.rb'
require './lib/player.rb'

class PlayerTest < Minitest::Test

  def test_player_exists
    player = Player.new

    assert_instance_of Player, player
  end

  def test_player_initializes_with_two_surviving_ships
    player = Player.new

    assert 2, player.surviving_ships
  end

  def test_player_can_place_a_ship
    game = Game.new
    board = Board.new
    player = Player.new

    assert_instance_of Ship, player.place_ship([[0, 0], [0, 1]], board.grid)
  end

  def test_player_can_fire_a_shot
    skip
    game = Game.new
    board = Board.new
    player = Player.new
    coordinate = [0, 0]

    message = player.determine_damaged_ship(coordinate, board.grid, player)
    assert_equal 'Your shot missed.', message
  end

  def test_we_can_output_correct_hit_message
    skip
    game = Game.new
    board = Board.new
    player = Player.new
    ship = player.destroyer

    assert_equal 'You hit an enemy ship!', player.hit_message(ship, player)
  end

  def test_we_can_output_correct_hit_message
    skip
    game = Game.new
    board = Board.new
    player = Player.new
    ship = player.destroyer

    assert_equal "You SUNK the enemy destroyer!", player.hit_message(ship, player)
  end


end
