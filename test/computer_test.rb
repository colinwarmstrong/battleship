require './test/test_helper.rb'
require './lib/computer.rb'
require './lib/ship.rb'
require './lib/player.rb'
require './lib/board.rb'
require './lib/space.rb'
require 'pry'

class ComputerTest < Minitest::Test
  attr_accessor :destroyer, :submarine

  def test_computer_exists
    computer = Computer.new

    assert_instance_of Computer, computer
  end

  def test_computer_starts_with_two_surviving_ships
    computer = Computer.new

    assert_equal 2, computer.surviving_ships
  end

  def test_computer_can_choose_a_random_orientation
    computer = Computer.new
    grid = Board.new.grid

    actual = computer.ship_orientation(2, grid)
    assert_instance_of Ship, actual
  end

  def test_computer_can_validate_horizontal_ship_placement
    computer = Computer.new
    grid = Board.new.grid

    actual = computer.horizontal_placement_validation(2, grid, 0, 0)
    assert_instance_of Array, actual
    assert_equal 3, actual.length
  end

  def test_computer_can_place_horizontal_ships_with_proper_attributes
    computer = Computer.new

    ship = computer.create_horizontal_ship(2, 0, 0)

    assert_instance_of Ship, ship
    assert_equal [[0, 0], [0, 1]], ship.coordinates
    assert_equal 2, ship.hit_points
    assert_equal 2, ship.ship_length
  end

  def test_computer_can_validate_vertical_placement
    computer = Computer.new
    grid = Board.new.grid

    actual = computer.vertical_placement_validation(2, grid, 0, 0)
    assert_instance_of Array, actual
    assert_equal 3, actual.length
  end

  def test_computer_can_place_vertical_ships_with_proper_attributes
    computer = Computer.new

    ship = computer.create_vertical_ship(2, 0, 0)

    assert_instance_of Ship, ship
    assert_equal [[0, 0], [1, 0]], ship.coordinates
    assert_equal 2, ship.hit_points
    assert_equal 2, ship.ship_length
  end

  def test_computer_can_fire_random_shot
    computer = Computer.new
    player = Player.new
    grid = Board.new.grid

    message = computer.fire_random_shot(grid, player)
    assert_equal 'The shot missed.', message
  end

  def test_computer_can_convert_random_shot_coordinates_to_string
    computer = Computer.new

    assert_equal 'A1', computer.convert_random_shot_to_string(0, 0)
    assert_equal 'B2', computer.convert_random_shot_to_string(1, 1)
    assert_equal 'C3', computer.convert_random_shot_to_string(2, 2)
    assert_equal 'D4', computer.convert_random_shot_to_string(3, 3)
  end

  def test_computer_can_correctly_determine_which_ship_it_hit
    computer = Computer.new
    player = Player.new
    grid = Board.new.grid
    player.destroyer = Ship.new([[0, 0], [0, 1]])
    player.submarine = Ship.new([[1, 0], [1, 1], [1, 2]])

    message1 = computer.determine_damaged_ship(grid, player, 0, 0)
    message2 = computer.determine_damaged_ship(grid, player, 1, 0)

    assert_equal 'The enemy hit your destroyer!', message1
    assert_equal 'The enemy hit your submarine!', message2
  end

  def test_computer_can_correctly_display_hit_message
    computer = Computer.new
    player = Player.new
    player.destroyer = Ship.new([[0, 0], [0, 1]])

    message = computer.hit_message(player.destroyer, player)

    assert_equal "The enemy hit your destroyer!", message
  end

  def test_computer_can_correctly_display_sunk_message
    computer = Computer.new
    player = Player.new
    player.destroyer = Ship.new([[0, 0], [0, 1]])

    player.destroyer.take_damage
    player.destroyer.take_damage

    message = computer.hit_message(player.destroyer, player)

    assert_equal "The enemy SUNK your destroyer!", message
  end

end
