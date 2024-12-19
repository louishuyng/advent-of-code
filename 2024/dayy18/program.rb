require 'set'

# Parse input coordinates 
def parse_coordinates(input)
  input.strip.split("\n").map do |line|
    x, y = line.split(',').map(&:to_i)
    [x, y]
  end
end

# Create grid with corrupted cells from first 1024 coordinates
def create_grid(coordinates, size)
  corrupted = Set.new
  coordinates.take(1024).each do |x, y|
    corrupted.add([x, y]) if x <= size && y <= size
  end
  corrupted
end

# Check if position is valid (in bounds and not corrupted)
def valid_position?(pos, size, corrupted)
  x, y = pos
  x >= 0 && x <= size && y >= 0 && y <= size && !corrupted.include?(pos)
end

# Find shortest path using BFS
def find_shortest_path(corrupted, size)
  start = [0, 0]
  goal = [size, size]
  
  # Return -1 if start or end is corrupted
  return -1 if corrupted.include?(start) || corrupted.include?(goal)
  
  queue = [[start, 0]]  # [position, steps]
  visited = Set.new([start])
  
  # Possible moves: right, down, left, up
  moves = [[1, 0], [0, 1], [-1, 0], [0, -1]]
  
  while !queue.empty?
    pos, steps = queue.shift
    
    # Return steps if we reached the goal
    return steps if pos == goal
    
    # Try each possible move
    moves.each do |dx, dy|
      new_pos = [pos[0] + dx, pos[1] + dy]
      
      if valid_position?(new_pos, size, corrupted) && !visited.include?(new_pos)
        queue.push([new_pos, steps + 1])
        visited.add(new_pos)
      end
    end
  end
  
  -1  # Return -1 if no path found
end

# Example usage

# Read file and parse coordinates
coordinates = parse_coordinates(File.read('example_input'))
corrupted = create_grid(coordinates.take(12), 6)
steps = find_shortest_path(corrupted, 6)
puts "Example (first 12 bytes) shortest path: #{steps} steps"

# Process full problem with size 70 and 1024 bytes
coordinates = parse_coordinates(File.read('input'))
corrupted = create_grid(coordinates, 70)
steps = find_shortest_path(corrupted, 70)
puts "Full problem shortest path: #{steps} steps"
