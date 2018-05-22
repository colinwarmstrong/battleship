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

  def test_we_can_verify_user_inputs_two_coordinates_for_destryoer
    skip
    game = Game.new

    assert game.verify_given_two_coordinates('A1 A2', game.player.grid)
  end

  def test_we_can_verify_correct_destroyer_coordinates_given
    skip
    game = Game.new

    assert game.verify_correct_coordinates([[0, 0], [0, 1]], game.player.grid)
  end

  def test_we_can_verify_destroyer_is_horizontal_or_vertical
    skip
    game =  Game.new

    assert game.verify_horizontal_or_vertical(coord_array, grid)
  end

  def test_we_can_verify_destroyer_units_are_adjacent
    skip
    game = Game.new

    assert game.verify_units_are_adjacent(coord_array, grid)
  end

  def test_we_can_verify_given_three_sub_coordinates
    skip
  end

  def test_we_can_verify_given_correct_sub_units
    skip
  end

  def test_we_can_verify_sub_is_vertical_or_horizontal
    skip
  end

  def test_we_can_verify_sub_units_are_adjacent
    skip
  end

  def test_we_can_verify_sub_units_are_unoccupied
    skip
  end

end
