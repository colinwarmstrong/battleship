require './test/test_helper.rb'
require './lib/game.rb'

class GameTest < Minitest::Test
  def test_game_exists
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

  def test_game_can_convert_individual_letter_coordinates_to_numeric
    game = Game.new

    assert_equal [0, 0], game.convert_individual_coordinate('a1')
    assert_equal [3, 3], game.convert_individual_coordinate('d4')
    assert_equal [2, 1], game.convert_individual_coordinate('c2')
  end

  def test_game_can_convert_multiple_coordinates_at_once
    game = Game.new

    coordinates1 = 'a1 a2'
    coordinates2 = 'b1 b2 b3'

    assert_equal [[0, 0], [0, 1]], game.convert_coordinates(coordinates1)
    assert_equal [[1, 0], [1, 1], [1, 2]], game.convert_coordinates(coordinates2)
  end
end
