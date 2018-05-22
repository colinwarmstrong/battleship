require 'minitest/autorun'
require 'minitest/pride'
require './lib/computer.rb'

class ComputerTest < Minitest::Test

  def test_it_exists
    computer = Computer.new

    assert_instance_of Computer, computer
  end

  def test_it_can_choose_a_random_orientation
    skip
    computer = Computer.new

    computer.ship_orientation(2, @player.grid)
  end

  def test_it_can_validate_horizontal_placement
    skip
    computer = Computer.new

     assert_nil computer.horizontal_placement_validation(2, @player.grid, 0, 0)
   end

   def test_it_can_place_horizontal_ships
     skip
     computer = Computer.new
   end

   def test_it_can_create_horizontal_ships_with_proper_attributes
     computer = Computer.new

     ship = computer.create_horizontal_ship(3, 0, 0)

     assert_instance_of Ship, ship
     assert_equal [[0, 0], [0, 1], [0, 2]], ship.coordinates
     assert_equal 3, ship.hit_points
     assert_equal 3, ship.ship_length
   end

end
