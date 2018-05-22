class Board

  attr_accessor :grid

  def initialize
    @grid = create_empty_grid
  end

  def create_empty_grid
    grid = []
    4.times { grid << [Space.new, Space.new, Space.new, Space.new] }
    return grid
  end

end
