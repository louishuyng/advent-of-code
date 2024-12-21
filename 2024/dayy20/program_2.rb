require 'set'

class RaceSolver
  DIRECTIONS = [[0, 1], [1, 0], [0, -1], [-1, 0]] # right, down, left, up
  MAX_CHEAT_TIME = 20

  def initialize(input)
    @grid = input.split("\n").map(&:chars)
    @height = @grid.length
    @width = @grid[0].length
    @start = find_position('S')
    @end = find_position('E')
    @base_path_length = find_shortest_path(@start, @end)
  end

  def find_position(char)
    @grid.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        return [y, x] if cell == char
      end
    end
  end

  def find_shortest_path(start, target)
    distances = {}
    queue = [[start, 0]]
    distances[start] = 0

    until queue.empty?
      pos, dist = queue.shift
      next if dist > distances[pos]

      DIRECTIONS.each do |dy, dx|
        ny = pos[0] + dy
        nx = pos[1] + dx
        next_pos = [ny, nx]
        next unless valid_move?(ny, nx)

        new_dist = dist + 1
        if !distances[next_pos] || new_dist < distances[next_pos]
          distances[next_pos] = new_dist
          queue << [next_pos, new_dist]
        end
      end
    end

    distances[target] || Float::INFINITY
  end

  def valid_move?(y, x)
    return false if y < 0 || y >= @height || x < 0 || x >= @width

    @grid[y][x] != '#'
  end

  def find_significant_cheats(min_savings)
    # Store cheats by their start and end positions to avoid duplicates
    cheat_savings = Hash.new(0)
    all_distances_to_start = find_all_distances(@start)
    all_distances_to_end = find_all_distances(@end)

    # Try every possible position as cheat start point
    @height.times do |y1|
      @width.times do |x1|
        start_pos = [y1, x1]
        next unless all_distances_to_start[start_pos] # Must be reachable from start

        # For each start position, try all positions within MAX_CHEAT_TIME Manhattan distance
        @height.times do |y2|
          @width.times do |x2|
            end_pos = [y2, x2]
            manhattan_dist = (y2 - y1).abs + (x2 - x1).abs
            next if manhattan_dist == 0 # Must move at least one step
            next if manhattan_dist > MAX_CHEAT_TIME # Can't exceed max cheat time
            next if @grid[y2][x2] == '#' # Must land on track
            next unless all_distances_to_end[end_pos] # Must be able to reach end

            # Calculate total path length with this cheat
            path_to_cheat = all_distances_to_start[start_pos]
            path_from_cheat = all_distances_to_end[end_pos]
            total_path = path_to_cheat + manhattan_dist + path_from_cheat

            savings = @base_path_length - total_path
            # Store the best savings for this start/end combination
            cheat_key = [start_pos, end_pos]
            cheat_savings[cheat_key] = [cheat_savings[cheat_key], savings].max
          end
        end
      end
    end

    # Count cheats that save at least min_savings picoseconds
    cheat_savings.count { |_, savings| savings >= min_savings }
  end

  private

  def in_bounds?(y, x)
    y >= 0 && y < @height && x >= 0 && x < @width
  end

  def find_all_distances(start)
    distances = {}
    queue = [[start, 0]]
    distances[start] = 0

    until queue.empty?
      pos, dist = queue.shift
      next if dist > distances[pos]

      DIRECTIONS.each do |dy, dx|
        ny = pos[0] + dy
        nx = pos[1] + dx
        next_pos = [ny, nx]
        next unless valid_move?(ny, nx)

        new_dist = dist + 1
        if !distances[next_pos] || new_dist < distances[next_pos]
          distances[next_pos] = new_dist
          queue << [next_pos, new_dist]
        end
      end
    end

    distances
  end
end

# Read input and solve
input = File.read('input')
solver = RaceSolver.new(input)
puts solver.find_significant_cheats(100)
