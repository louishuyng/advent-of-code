require 'set'

# Parse input coordinates
def parse_coordinates(input)
  input.strip.split("\n").map do |line|
    x, y = line.split(',').map(&:to_i)
    [x, y]
  end
end

# Check if position is valid (in bounds and not corrupted)
def valid_position?(pos, size, corrupted)
  x, y = pos
  x >= 0 && x <= size && y >= 0 && y <= size && !corrupted.include?(pos)
end

# Find if path exists using BFS
def path_exists?(corrupted, size)
  start = [0, 0]
  goal = [size, size]

  # Return false if start or end is corrupted
  return false if corrupted.include?(start) || corrupted.include?(goal)

  queue = [start]
  visited = Set.new([start])

  # Possible moves: right, down, left, up
  moves = [[1, 0], [0, 1], [-1, 0], [0, -1]]

  until queue.empty?
    pos = queue.shift

    # Return true if we reached the goal
    return true if pos == goal

    # Try each possible move
    moves.each do |dx, dy|
      new_pos = [pos[0] + dx, pos[1] + dy]

      if valid_position?(new_pos, size, corrupted) && !visited.include?(new_pos)
        queue.push(new_pos)
        visited.add(new_pos)
      end
    end
  end

  false # Return false if no path found
end

# Find first blocking byte
def find_blocking_byte(coordinates, size)
  corrupted = Set.new

  coordinates.each_with_index do |coord, _i|
    corrupted.add(coord)

    # Check if path exists after adding this byte
    unless path_exists?(corrupted, size)
      return coord # Return coordinates of blocking byte
    end
  end

  nil # Return nil if no blocking byte found
end

# Process example
coordinates = parse_coordinates(File.read('example_input'))
blocking_byte = find_blocking_byte(coordinates, 6)
puts "#{blocking_byte[0]},#{blocking_byte[1]}"

# Process full problem
coordinates = parse_coordinates(File.read('input'))
blocking_byte = find_blocking_byte(coordinates, 70)
puts "#{blocking_byte[0]},#{blocking_byte[1]}"
