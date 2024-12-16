require 'set'

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
    start_state = {
      pos: @start,
      direction: :east,
      score: 0
    }

    visited = Set.new
    queue = [start_state]

    until queue.empty?
      # Sort and take the lowest score state
      queue.sort_by! { |state| state[:score] }
      current = queue.shift

      # Found the end
      return current[:score] if current[:pos] == @end_pos

      # Create a unique state key for visited tracking
      state_key = [current[:pos], current[:direction]]
      next if visited.include?(state_key)

      visited.add(state_key)

      # Four possible moves: forward, rotate left, rotate right
      [
        # Move forward
        {
          type: :forward,
          new_pos: [
            current[:pos][0] + MOVES[current[:direction]][0],
            current[:pos][1] + MOVES[current[:direction]][1]
          ],
          new_direction: current[:direction],
          score_delta: 1
        },
        # Rotate left
        {
          type: :rotate_left,
          new_pos: current[:pos],
          new_direction: DIRECTIONS[(DIRECTIONS.index(current[:direction]) - 1) % 4],
          score_delta: 1000
        },
        # Rotate right
        {
          type: :rotate_right,
          new_pos: current[:pos],
          new_direction: DIRECTIONS[(DIRECTIONS.index(current[:direction]) + 1) % 4],
          score_delta: 1000
        }
      ].each do |move|
        next_pos = move[:new_pos]

        # Check if move is valid
        next if
          next_pos[0] < 0 || next_pos[0] >= @height ||
          next_pos[1] < 0 || next_pos[1] >= @width ||
          @maze[next_pos[0]][next_pos[1]] == '#'

        next_state = {
          pos: next_pos,
          direction: move[:new_direction],
          score: current[:score] + move[:score_delta]
        }

        queue << next_state
      end
    end

    nil # No path found
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
end

# Read maze from input file
def read_maze_from_file(filename)
  File.readlines(filename, chomp: true)
end

input_file = 'input'
maze = read_maze_from_file(input_file)
solver = ReindeerMazeSolver.new(maze)
result = solver.solve

puts "Lowest score: #{result}"
