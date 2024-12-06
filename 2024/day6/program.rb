require './input_reader'

def program
  row, current_position, current_direction, obstacles = read_input

  puts "Current position: #{current_position}"
  puts "Current direction: #{current_direction}"
  puts "Obstacles: #{obstacles}"
  puts "Row: #{row}"

  steps = 0
  has_visited = {}

  until over_tank?(current_position, row, row)
    if face_obstacle?(next_move(current_position, current_direction), obstacles)
      current_direction = rotate_position_90_degree(current_direction)
    else
      current_position = next_move(current_position, current_direction)

      has_visited[current_position[0]] = [] unless has_visited[current_position[0]]

      next if has_visited[current_position[0]].include?(current_position[1])

      has_visited[current_position[0]] << current_position[1]
      steps += 1
    end
  end

  puts "Steps: #{steps}"
end

def over_tank?(current_position, row, col)
  current_position[0].zero? \
  || current_position[0] == row - 1 \
  || current_position[1].zero? \
  || current_position[1] == col - 1
end

def face_obstacle?(current_position, obstacles)
  obstacles[current_position[0]].include?(current_position[1])
end

def next_move(current_position, current_direction)
  next_position = current_position.dup
  next_position[0] += next_direction(current_direction)[0]
  next_position[1] += next_direction(current_direction)[1]
  next_position
end

def rotate_position_90_degree(current_direction)
  {
    'up': 'right',
    'right': 'down',
    'down': 'left',
    'left': 'up'
  }[current_direction.to_sym]
end

def next_direction(current_direction)
  {
    "up": [-1, 0],
    "right": [0, 1],
    "down": [1, 0],
    "left": [0, -1]
  }[current_direction.to_sym]
end

program
