require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship.rb'

class ShipTest < Minitest::Test

  def test_ships_exist
    ship = Ship.new([0, 0])

    assert_instance_of Ship, ship
  end

  def test_ships_initialize_with_correct_coordinates
    ship1 = Ship.new([[0, 0], [0, 1]])
    ship2 = Ship.new([[1, 0], [1, 1], [1, 2]])

    assert_equal [[0, 0], [0, 1]], ship1.coordinates
    assert_equal [[1, 0], [1, 1], [1, 2]], ship2.coordinates
  end

  def test_ships_initialize_with_correct_hit_points
    ship1 = Ship.new([[0, 0], [0, 1]])
    ship2 = Ship.new([[1, 0], [1, 1], [1, 2]])

    assert_equal 2, ship1.hit_points
    assert_equal 3, ship2.hit_points
  end

  def test_ships_initialize_with_correct_ship_length
    ship1 = Ship.new([[0, 0], [0, 1]])
    ship2 = Ship.new([[1, 0], [1, 1], [1, 2]])

    assert_equal 2, ship1.ship_length
    assert_equal 3, ship2.ship_length
  end

  def test_ships_can_take_damage
    ship1 = Ship.new([[0, 0], [0, 1]])

    assert_equal 2, ship1.hit_points
    ship1.take_damage
    assert_equal 1, ship1.hit_points
    ship1.take_damage
    assert_equal 0, ship1.hit_points
  end

  def test_ships_can_correctly_return_sunk_or_not_sunk
    ship1 = Ship.new([[0, 0], [0, 1]])

    refute ship1.sunk?
    ship1.take_damage
    refute ship1.sunk?
    ship1.take_damage
    assert ship1.sunk?
  end

  def test_ships_return_correct_name_based_on_ship_length
    ship1 = Ship.new([[0, 0], [0, 1]])
    ship2 = Ship.new([[1, 0], [1, 1], [1, 2]])

    assert_equal 'destroyer', ship1.name
    assert_equal 'submarine', ship2.name
  end

end
