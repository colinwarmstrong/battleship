require 'minitest/autorun'
require 'minitest/pride'
require './lib/space.rb'

class SpaceTest < Minitest::Test

  def test_it_exists
    space = Space.new

    assert_instance_of Space, space
  end

end
