def has_gap_between_file_blocks(spaces)
  position_free = find_position_free_at_the_left(spaces)

  (position_free..spaces.length - 1).each do |i|
    return true if spaces[i] != '.'
  end

  false
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
