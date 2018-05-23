class Board
  attr_reader :grid

  def initialize
    @grid = create_empty_grid
  end

  def create_empty_grid
    grid = []
    4.times { grid << [Space.new, Space.new, Space.new, Space.new] }
    return grid
  end

  def display_cpu_grid
    puts '=========='
    puts '. 1 2 3 4'
    puts "A #{grid[0][0].cpu_display} #{grid[0][1].cpu_display} #{grid[0][2].cpu_display} #{grid[0][3].cpu_display}"
    puts "B #{grid[1][0].cpu_display} #{grid[1][1].cpu_display} #{grid[1][2].cpu_display} #{grid[1][3].cpu_display}"
    puts "C #{grid[2][0].cpu_display} #{grid[2][1].cpu_display} #{grid[2][2].cpu_display} #{grid[2][3].cpu_display}"
    puts "D #{grid[3][0].cpu_display} #{grid[3][1].cpu_display} #{grid[3][2].cpu_display} #{grid[3][3].cpu_display}"
    puts '=========='
  end

  def display_player_grid
    puts '=========='
    puts '. 1 2 3 4'
    puts "A #{grid[0][0].p1_display} #{grid[0][1].p1_display} #{grid[0][2].p1_display} #{grid[0][3].p1_display}"
    puts "B #{grid[1][0].p1_display} #{grid[1][1].p1_display} #{grid[1][2].p1_display} #{grid[1][3].p1_display}"
    puts "C #{grid[2][0].p1_display} #{grid[2][1].p1_display} #{grid[2][2].p1_display} #{grid[2][3].p1_display}"
    puts "D #{grid[3][0].p1_display} #{grid[3][1].p1_display} #{grid[3][2].p1_display} #{grid[3][3].p1_display}"
    puts '=========='
  end

  def display_both_grids(grid1, grid2, turns)
    puts 'ENEMY MAP        YOUR MAP'
    puts '==========      =========='
    puts '. 1 2 3 4       . 1 2 3 4  '
    puts "A #{grid1[0][0].cpu_display} #{grid1[0][1].cpu_display} #{grid1[0][2].cpu_display} #{grid1[0][3].cpu_display}       A #{grid2[0][0].p1_display} #{grid2[0][1].p1_display} #{grid2[0][2].p1_display} #{grid2[0][3].p1_display}"
    puts "B #{grid1[1][0].cpu_display} #{grid1[1][1].cpu_display} #{grid1[1][2].cpu_display} #{grid1[1][3].cpu_display}       B #{grid2[1][0].p1_display} #{grid2[1][1].p1_display} #{grid2[1][2].p1_display} #{grid2[1][3].p1_display}"
    puts "C #{grid1[2][0].cpu_display} #{grid1[2][1].cpu_display} #{grid1[2][2].cpu_display} #{grid1[2][3].cpu_display}       C #{grid2[2][0].p1_display} #{grid2[2][1].p1_display} #{grid2[2][2].p1_display} #{grid2[2][3].p1_display}"
    puts "D #{grid1[3][0].cpu_display} #{grid1[3][1].cpu_display} #{grid1[3][2].cpu_display} #{grid1[3][3].cpu_display}       D #{grid2[3][0].p1_display} #{grid2[3][1].p1_display} #{grid2[3][2].p1_display} #{grid2[3][3].p1_display}"
    puts '==========      =========='
    puts "----------TURN #{turns}----------"
  end

end
