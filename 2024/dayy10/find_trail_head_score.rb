def find_trail_head_score(map, start_positions, distinct_check = true)
  start_positions.map do |start_position|
    possible_end_positions = find_possible_end_positions_can_reach_from_start(map, start_position)

    calculate_trail_head_score(possible_end_positions, distinct_check)
  end.inject(:+)
end

def find_possible_end_positions_can_reach_from_start(map, start_position, result = [])
  current_char = map[start_position[0]][start_position[1]]

  if current_char == '9'
    new_result = result.dup
    new_result << start_position
    return new_result
  end

  directions = [
    [0, 1], # right
    [1, 0], # down
    [0, -1], # left
    [-1, 0] # up
  ]

  directions.each do |direction|
    new_position = [start_position[0] + direction[0], start_position[1] + direction[1]]

    unless new_position[0] >= 0 && new_position[0] < map.length \
      && new_position[1] >= 0 && new_position[1] < map[0].length
      next
    end

    new_char = map[new_position[0]][new_position[1]]

    next if new_char == '.'
    next if new_char.to_i - current_char.to_i != 1

    result = find_possible_end_positions_can_reach_from_start(map, new_position, result)
  end

  result
end

def calculate_trail_head_score(possible_end_positions, distinct_check)
  if distinct_check
    score = 0

    checked = {}
    possible_end_positions.each do |end_position|
      checked[end_position[0]] = {} unless checked[end_position[0]]
      next if checked[end_position[0]][end_position[1]]

      checked[end_position[0]][end_position[1]] = true
      score += 1
    end

    return score
  end

  possible_end_positions.length
end
