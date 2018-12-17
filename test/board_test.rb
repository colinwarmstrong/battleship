require './test/test_helper.rb'
require './lib/board.rb'
require './lib/space.rb'
require 'colorize'

class BoardTest < Minitest::Test
  def test_board_exists
    board = Board.new

    assert_instance_of Board, board
  end

  def test_board_initializes_as_a_four_by_four_grid
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

  def test_each_element_of_the_new_grid_is_empty_and_not_hit
    board = Board.new

    refute board.grid[0][0].filled?
    refute board.grid[1][2].filled?
    refute board.grid[3][3].hit?
    refute board.grid[2][3].hit?
  end

  def test_board_can_display_cpu_grid
    board = Board.new

    assert_nil board.display_cpu_grid
  end

  def test_board__can_display_player_grid
    board = Board.new

    assert_nil board.display_player_grid
  end

  def test_board_can_display_both_grids
    board = Board.new
    grid1 = Board.new.grid
    grid2 = Board.new.grid
    turns = 0

    assert_nil board.display_both_grids(grid1, grid2, turns)
  end
end
