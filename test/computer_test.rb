require 'minitest/autorun'
require 'minitest/pride'
require './lib/computer.rb'

class ComputerTest < Minitest::Test

  def test_it_exists
    computer = Computer.new

    assert_instance_of Computer, computer
  end

end
