require 'minitest/autorun'
require 'minitest/pride'
require './lib/game.rb'

class GameTest < Minitest::Test

  def test_it_exists
    game = Game.new

    assert_instance_of Game, game
  end

  def test_new_game_starts_with_proper_attributes
    game = Game.new

    assert_instance_of Player, game.player
    assert_instance_of Computer, game.computer
    assert_instance_of Board, game.player_board
    assert_instance_of Board, game.computer_board
    assert_equal 0, game.turns
    assert_equal 0 , game.start_time
  end

  def test_we_can_verify_user_inputs_two_coordinates
    skip
    game = Game.new

    assert game.verify_given_two_coordinates('A1 A2', game.player.grid)
  end

  def test_we_can_verify_correct_coordinates_given
    skip
    game = Game.new

    assert game.verify_correct_coordinates([[0, 0], [0, 1]], game.player.grid)
  end

  def test_we_can_verify_horizontal_or_vertical
    skip
    game =  Game.new

    assert game.verify_horizontal_or_vertical(coord_array, grid)
  end

  def test_we_can_verify_units_are_adjacent
    skip
    game = Game.new

    assert game.verify_units_are_adjacent(coord_array, grid)
  end

end
