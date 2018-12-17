require './test/test_helper.rb'
require './lib/space.rb'
require 'colorize'

class SpaceTest < Minitest::Test
  def test_space_exists
    space = Space.new

    assert_instance_of Space, space
  end

  def test_spaces_initialize_empty_and_not_hit
    space = Space.new

    refute space.filled
    refute space.hit
  end

  def test_we_can_fill_a_space
    space = Space.new

    refute space.filled
    space.fill
    assert space.filled
  end

  def test_we_can_check_if_space_is_filled_or_not
    space = Space.new

    refute space.filled?
    space.fill
    assert space.filled?
  end

  def test_a_space_can_take_a_hit
    space = Space.new

    refute space.hit
    space.take_hit
    assert space.hit
  end

  def test_we_can_check_if_space_has_been_hit_or_not
    space = Space.new

    refute space.hit?
    space.take_hit
    assert space.hit?
  end

  def test_spaces_correctly_display_for_player_one
    space1 = Space.new
    space2 = Space.new

    assert_equal '~'.light_blue, space1.p1_display
    space1.take_hit
    assert_equal 'M', space1.p1_display
    space1.fill
    assert_equal 'H'.red, space1.p1_display

    space2.fill
    assert_equal 'S'.light_black, space2.p1_display
  end

  def test_spaces_correctly_display_for_cpu
    space = Space.new

    assert_equal '~'.light_blue, space.cpu_display
    space.take_hit
    assert_equal 'M', space.cpu_display
    space.fill
    assert_equal 'H'.red, space.cpu_display
  end
end
