require 'minitest/autorun'
require 'minitest/pride'
require './lib/board.rb'
require './lib/space.rb'

class BoardTest < Minitest::Test

  def test_board_exists
    board = Board.new

    assert_instance_of Board, board
  end

  def test_board_initializes_as_an_empty_four_by_four_grid
    board = Board.new

    assert_equal 4, board.grid.length
    assert_equal 4, board.grid[0].length
    assert_equal 4, board.grid[1].length
    assert_equal 4, board.grid[2].length
    assert_equal 4, board.grid[3].length
  end

  def test_each_element_of_the_grid_is_an_instance_of_the_space_class
    board = Board.new

    assert_instance_of Space, board.grid[0][0]
    assert_instance_of Space, board.grid[3][3]
    assert_instance_of Space, board.grid[1][2]
    assert_instance_of Space, board.grid[2][3]
  end

end
