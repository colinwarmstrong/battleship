require './test/test_helper.rb'
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

  def test_player_can_place_a_ship_with_correct_coordinates
    board = Board.new
    player = Player.new

    ship = player.place_ship([[0, 0], [0, 1]], board.grid)

    assert_instance_of Ship, ship
    assert_equal [[0, 0], [0, 1]], ship.coordinates
  end

  def test_player_can_fire_a_shot_at_empty_space
    board = Board.new
    player = Player.new
    computer = Computer.new
    coordinate = [0, 0]

    message = player.fire_shot(coordinate, board.grid, computer)

    assert_equal 'Your shot missed.', message
  end

  def test_player_can_fire_hit_the_destroyer
    board = Board.new
    player = Player.new
    computer = Computer.new
    computer.destroyer = Ship.new([[0, 0], [0, 1]])
    computer.submarine = Ship.new([[1, 0], [1, 1], [1, 2]])
    grid = board.grid
    coordinate = [0, 0]

    grid[0][0].fill

    assert_equal 'You hit an enemy ship!', player.fire_shot(coordinate, grid, computer)
  end

  def test_player_can_hit_the_submarine
    board = Board.new
    player = Player.new
    computer = Computer.new
    computer.destroyer = Ship.new([[0, 0], [0, 1]])
    computer.submarine = Ship.new([[1, 0], [1, 1], [1, 2]])
    grid = board.grid
    coordinate = [1, 0]

    grid[1][0].fill

    assert_equal 'You hit an enemy ship!', player.fire_shot(coordinate, grid, computer)
  end

  def test_player_shot_can_sink_a_ship
    board = Board.new
    player = Player.new
    computer = Computer.new
    computer.destroyer = Ship.new([[0, 0], [0, 1]])
    computer.submarine = Ship.new([[1, 0], [1, 1], [1, 2]])
    grid = board.grid
    coordinate1 = [0, 0]
    coordinate2 = [0, 1]

    grid[0][0].fill
    grid[0][1].fill

    assert_equal 2, computer.surviving_ships

    player.fire_shot(coordinate1, grid, computer)
    message = player.fire_shot(coordinate2, grid, computer)

    assert_equal 'You SUNK the enemy destroyer!', message
    assert_equal 1, computer.surviving_ships
  end
end
