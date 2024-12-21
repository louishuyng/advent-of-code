require 'set'

class RaceSolver
  DIRECTIONS = [[0, 1], [1, 0], [0, -1], [-1, 0]]  # right, down, left, up
  
  def initialize(input)
    @grid = input.split("\n").map(&:chars)
    @height = @grid.length
    @width = @grid[0].length
    @start = find_position('S')
    @end = find_position('E')
    # First, find base path length without cheating
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
    
    while !queue.empty?
      pos, dist = queue.shift
      next if dist > distances[pos]
      
      DIRECTIONS.each do |dy, dx|
        ny, nx = pos[0] + dy, pos[1] + dx
        next_pos = [ny, nx]
        next if !valid_move?(ny, nx)
        
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
    significant_cheats = 0
    all_distances_to_start = find_all_distances(@start)
    all_distances_to_end = find_all_distances(@end)
    
    # Try every possible position as cheat start point
    @height.times do |y1|
      @width.times do |x1|
        next unless all_distances_to_start[[y1, x1]]  # Must be reachable from start
        
        # Try all possible landing spots within 1-2 moves
        (-2..2).each do |dy|
          (-2..2).each do |dx|
            next if dy.abs + dx.abs > 2  # Can only move 1-2 steps total
            next if dy.abs + dx.abs == 0  # Must move at least one step
            
            y2 = y1 + dy
            x2 = x1 + dx
            next unless in_bounds?(y2, x2)
            next if @grid[y2][x2] == '#'  # Must land on track
            next unless all_distances_to_end[[y2, x2]]  # Must be able to reach end
            
            # Calculate total path length with this cheat
            path_to_cheat = all_distances_to_start[[y1, x1]]
            path_from_cheat = all_distances_to_end[[y2, x2]]
            cheat_path = path_to_cheat + (dy.abs + dx.abs) + path_from_cheat
            
            savings = @base_path_length - cheat_path
            significant_cheats += 1 if savings >= min_savings
          end
        end
      end
    end
    
    significant_cheats
  end

  private

  def in_bounds?(y, x)
    y >= 0 && y < @height && x >= 0 && x < @width
  end

  def find_all_distances(start)
    distances = {}
    queue = [[start, 0]]
    distances[start] = 0
    
    while !queue.empty?
      pos, dist = queue.shift
      next if dist > distances[pos]
      
      DIRECTIONS.each do |dy, dx|
        ny, nx = pos[0] + dy, pos[1] + dx
        next_pos = [ny, nx]
        next if !valid_move?(ny, nx)
        
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
