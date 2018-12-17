module Verification
  def convert_coordinates(letter_coordinates)
    letter_coordinates_split = letter_coordinates.split(' ')
    letter_coordinates_split.map! do |coordinate|
      convert_individual_coordinate(coordinate)
    end
  end

  def convert_individual_coordinate(coordinate)
    characters = coordinate.chars
    if characters[0] == 'a'
      return [0, characters[1].to_i - 1]
    elsif characters[0] == 'b'
      return [1, characters[1].to_i - 1]
    elsif characters[0] == 'c'
      return [2, characters[1].to_i - 1]
    elsif characters[0] == 'd'
      return [3, characters[1].to_i - 1]
    else
      return [4, 4]
    end
  end

  def verify_destroyer(coordinates)
    numeric_coord = convert_coordinates(coordinates)
    verify_given_two_destroyer_coordinates(coordinates)
    verify_given_correct_destroyer_coordinates(coordinates)
    verify_destroyer_horizontal_or_vertical(numeric_coord)
    verify_destroyer_units_are_adjacent(numeric_coord)
  end

  def verify_given_two_destroyer_coordinates(coordinates)
    if coordinates.split.length != 2 || coordinates.delete(' ').chars.length != 4
      puts 'Please enter two coordinates seperated by spaces in the form A1. Try agin.'
      return player_destroyer_placement
    end
  end

  def verify_given_correct_destroyer_coordinates(coordinates)
    numeric_coord = coordinates.delete(' ').chars
    if !(('a'..'d').include?(numeric_coord[0])) || !(('a'..'d').include?(numeric_coord[2]))
      puts 'Make sure your coordinates are between A1 and D4. Try again.'
      return player_destroyer_placement
    elsif !(('1'..'4').include?(numeric_coord[1])) || !(('1'..'4').include?(numeric_coord[3]))
      puts 'Make sure your coordinates are between A1 and D4. Try again.'
      return player_destroyer_placement
    end
  end

  def verify_destroyer_horizontal_or_vertical(numeric_coord)
    if numeric_coord[0][0] != numeric_coord[1][0] && numeric_coord[0][1] != numeric_coord[1][1]
      puts 'Ships must be placed horizontally or vertically. Try again.'
      return player_destroyer_placement
    end
  end

  def verify_destroyer_units_are_adjacent(numeric_coord)
    if numeric_coord[0][0] != numeric_coord[1][0] - 1 && numeric_coord[1][0] != numeric_coord[0][0] - 1 && numeric_coord[0][1] != numeric_coord[1][1] - 1 && numeric_coord[1][1] != numeric_coord[0][1] - 1
      puts 'All units must be adjacent. Try again.'
      return player_destroyer_placement
    end
  end

  def verify_submarine(coordinates, grid)
    numeric_coord = convert_coordinates(coordinates)
    verify_given_three_sub_coordinates(coordinates)
    verify_given_correct_sub_coordinates(coordinates)
    verify_sub_horizontal_or_vertical(numeric_coord)
    verify_sub_units_are_horizontally_adjacent(numeric_coord)
    verify_sub_units_are_vertically_adjacent(numeric_coord)
    verify_sub_units_are_unoccupied(numeric_coord, grid)
  end

  def verify_given_three_sub_coordinates(coordinates)
    if coordinates.split.length != 3 || coordinates.delete(' ').chars.length != 6
      puts 'Please enter three coordinates seperated by spaces in the form A1. Try agin.'
      return player_submarine_placement
    end
  end

  def verify_given_correct_sub_coordinates(coordinates)
    numeric_coord = coordinates.delete(' ').chars
    if !(('a'..'d').include?(numeric_coord[0])) || !(('a'..'d').include?(numeric_coord[2])) || !(('a'..'d').include?(numeric_coord[4]))
      puts 'Make sure your coordinates are between A1 and D4. Try again.'
      return player_submarine_placement
    elsif !(('1'..'4').include?(numeric_coord[1])) || !(('1'..'4').include?(numeric_coord[3])) || !(('1'..'4').include?(numeric_coord[5]))
      puts 'Make sure your coordinates are between A1 and D4. Try again.'
      return player_submarine_placement
    end
  end

  def verify_sub_horizontal_or_vertical(numeric_coord)
    if (numeric_coord[0][0] != numeric_coord[1][0] || numeric_coord[0][0] != numeric_coord[2][0] || numeric_coord[1][0] != numeric_coord[2][0]) && (numeric_coord[0][1] != numeric_coord[1][1] || numeric_coord[0][1] != numeric_coord[2][1] || numeric_coord[1][1] != numeric_coord[2][1])
      puts 'Ships must be placed horizontally or vertically. Try again.'
      return player_submarine_placement
    end
  end

  def verify_sub_units_are_horizontally_adjacent(numeric_coord)
    if (numeric_coord[0][0] - numeric_coord[1][0]).abs > 1 || (numeric_coord[0][0] - numeric_coord[2][0]).abs > 2 || (numeric_coord[1][0] - numeric_coord[2][0]).abs > 2
      puts 'Make sure your coordinates are consecutive and adjacent. Try again.'
      return player_submarine_placement
    end
  end

  def verify_sub_units_are_vertically_adjacent(numeric_coord)
    if (numeric_coord[0][1] - numeric_coord[1][1]).abs > 1 || (numeric_coord[0][1] - numeric_coord[2][1]).abs > 2 || (numeric_coord[1][1] - numeric_coord[2][1]).abs > 2
      puts 'Make sure your coordinates are consecutive and adjacent. Try again.'
      return player_submarine_placement
    end
  end

  def verify_sub_units_are_unoccupied(numeric_coord, grid)
    numeric_coord.each do |coordinate|
      if grid[coordinate[0]][coordinate[1]].filled?
        puts 'Ships cannot overlap. Try again.'
        return player_submarine_placement
      end
    end
  end

  def verify_shot(coordinate)
    numeric_coord = convert_coordinates(coordinate).flatten!
    if coordinate.strip.length != 2 || coordinate.nil?
      puts 'Please enter one coordinate in the form A1. Try again.'
      return player_shot_sequence
    elsif !((0..3).include?(numeric_coord[0])) || !((0..3).include?(numeric_coord[1]))
      puts 'Make sure your coordinate is between A1 and D4. Try again.'
      return player_shot_sequence
    elsif @computer_board.grid[numeric_coord[0]][numeric_coord[1]].hit?
      puts 'You have already fired at this coordinate. Try again.'
      return player_shot_sequence
    end
  end
end
