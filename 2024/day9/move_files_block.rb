def move_files_block_to_free_left(spaces, space_id)
  positions_space_id = find_positions_of_space_id(spaces, space_id)
  lower_position_of_space_id = positions_space_id.min

  free_spaces = find_continuous_positions(spaces, positions_space_id.length, lower_position_of_space_id)

  if free_spaces.empty?
    puts 'No free space to move block'
    return nil
  end

  positions_space_id.each_with_index do |position, index|
    spaces[free_spaces[index]] = space_id
    spaces[position] = '.'
  end

  spaces
end

def find_positions_of_space_id(spaces, space_id)
  positions = []

  spaces.each_with_index do |space, index|
    positions << index if space == space_id
  end

  positions
end

def find_continuous_positions(spaces, continuous_length, max_position)
  free_spaces = []

  (0..max_position).each do |position|
    if spaces[position] == '.'
      free_spaces << position
    else
      free_spaces = []
    end

    break if free_spaces.length == continuous_length
  end

  free_spaces
end
