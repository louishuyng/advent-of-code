def move_file_block_from_end_to_free_left(spaces)
  end_block, block_position = find_block_at_the_end(spaces)
  position_left_free = find_position_free_at_the_left(spaces)

  puts "Move block from #{block_position} to #{position_left_free}"

  spaces[position_left_free] = end_block
  spaces[block_position] = '.'

  spaces
end

def find_block_at_the_end(spaces)
  current = '.'
  position = spaces.length - 1

  until current != '.'
    return nil if position.negative?

    current = spaces[position]
    position -= 1
  end

  [current, position + 1]
end

def find_position_free_at_the_left(spaces)
  current = '0'
  position = 0

  until current == '.'
    return nil if position > spaces.length - 1

    current = spaces[position]
    position += 1
  end

  position - 1
end
