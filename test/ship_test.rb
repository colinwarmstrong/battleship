require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship.rb'

class ShipTest < Minitest::Test

  def test_it_exists
    ship = Ship.new([0, 0])

    assert_instance_of Ship, ship
  end

end
