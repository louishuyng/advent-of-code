require 'set'

class MinHeap
  def initialize
    @elements = []
  end

  def push(element, priority)
    @elements << [priority, element]
    bubble_up(@elements.size - 1)
  end

  def pop
    return nil if empty?

    swap(0, @elements.size - 1)
    element = @elements.pop.last
    bubble_down(0)
    element
  end

  def empty?
    @elements.empty?
  end

  private

  def bubble_up(index)
    while index > 0
      parent_index = (index - 1) / 2
      break if @elements[parent_index][0] <= @elements[index][0]

      swap(parent_index, index)
      index = parent_index
    end
  end

  def bubble_down(index)
    loop do
      left_child_index = 2 * index + 1
      right_child_index = 2 * index + 2
      smallest_index = index

      if left_child_index < @elements.size && @elements[left_child_index][0] < @elements[smallest_index][0]
        smallest_index = left_child_index
      end

      if right_child_index < @elements.size && @elements[right_child_index][0] < @elements[smallest_index][0]
        smallest_index = right_child_index
      end

      break if smallest_index == index

      swap(index, smallest_index)
      index = smallest_index
    end
  end

  def swap(i, j)
    @elements[i], @elements[j] = @elements[j], @elements[i]
  end
end

class ReindeerMazeSolver
  DIRECTIONS = %i[east south west north]
  MOVES = {
    east: [0, 1],
    south: [1, 0],
    west: [0, -1],
    north: [-1, 0]
  }

  def initialize(maze)
    @maze = maze.map(&:chars)
    @height = @maze.length
    @width = @maze[0].length
    @start = find_position('S')
    @end_pos = find_position('E')
  end

  def solve
    queue = MinHeap.new
    queue.push({ pos: @start, direction: :east, score: 0, path: [@start] }, 0)

    best_solutions = []
    best_score = Float::INFINITY
    visited = {}

    until queue.empty?
      current = queue.pop

      next if current[:score] > best_score

      if current[:pos] == @end_pos
        if current[:score] < best_score
          best_score = current[:score]
          best_solutions = [current]
        elsif current[:score] == best_score
          best_solutions << current
        end
        next
      end

      state_key = [current[:pos], current[:direction]]

      next if visited[state_key] && visited[state_key] < current[:score]

      visited[state_key] = current[:score]

      # Four possible moves: forward, rotate left, rotate right
      [
        { type: :forward, new_pos: move_position(current[:pos], current[:direction]),
          new_direction: current[:direction], score_delta: 1 },
        { type: :rotate_left, new_pos: current[:pos],
          new_direction: DIRECTIONS[(DIRECTIONS.index(current[:direction]) - 1) % 4], score_delta: 1000 },
        { type: :rotate_right, new_pos: current[:pos],
          new_direction: DIRECTIONS[(DIRECTIONS.index(current[:direction]) + 1) % 4], score_delta: 1000 }
      ].each do |move|
        next_pos = move[:new_pos]
        next if invalid_move?(next_pos)

        next_path = current[:path] + [next_pos]
        next_state = { pos: next_pos, direction: move[:new_direction], score: current[:score] + move[:score_delta],
                       path: next_path }

        queue.push(next_state, next_state[:score])
      end
    end

    # Collect and count unique path tiles
    path_tiles = best_solutions.flat_map { |sol| sol[:path] }.uniq

    {
      lowest_score: best_score,
      unique_path_tiles: path_tiles.count { |pos| ['.', 'S', 'E'].include?(@maze[pos[0]][pos[1]]) }
    }
  end

  private

  def find_position(char)
    @maze.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        return [y, x] if cell == char
      end
    end
    nil
  end

  def move_position(pos, direction)
    [
      pos[0] + MOVES[direction][0],
      pos[1] + MOVES[direction][1]
    ]
  end

  def invalid_move?(pos)
    pos[0] < 0 || pos[0] >= @height ||
      pos[1] < 0 || pos[1] >= @width ||
      @maze[pos[0]][pos[1]] == '#'
  end
end

# Read maze from input file
def read_maze_from_file(filename)
  File.readlines(filename, chomp: true)
end

maze = read_maze_from_file('input')
solver = ReindeerMazeSolver.new(maze)

# Solve both parts
result = solver.solve

puts "Part 1 - Lowest Score: #{result[:lowest_score]}"
puts "Part 2 - Unique Path Tiles: #{result[:unique_path_tiles]}"
