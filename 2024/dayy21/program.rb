# Point class for handling 2D coordinates
Point = Struct.new(:x, :y) do
  def -(other)
    Point.new(x - other.x, y - other.y)
  end
end

class KeypadSolver
  def initialize
    @lookup = {}
  end

  def numeric_keypad(start, finish)
    button = lambda do |c|
      case c
      when '9' then Point.new(2, 0)
      when '8' then Point.new(1, 0)
      when '7' then Point.new(0, 0)
      when '6' then Point.new(2, 1)
      when '5' then Point.new(1, 1)
      when '4' then Point.new(0, 1)
      when '3' then Point.new(2, 2)
      when '2' then Point.new(1, 2)
      when '1' then Point.new(0, 2)
      when 'A' then Point.new(2, 3)
      when '0' then Point.new(1, 3)
      else raise "Invalid button: #{c}"
      end
    end

    a = button.call(start)
    b = button.call(finish)
    diff = b - a

    xs = case diff.x <=> 0
         when 1 then '>' * diff.x
         when -1 then '<' * -diff.x
         else ''
         end

    ys = case diff.y <=> 0
         when 1 then 'v' * diff.y
         when -1 then '^' * -diff.y
         else ''
         end

    output = []

    # Check boundary conditions
    output << "#{xs}#{ys}A" unless a.y == 3 && b.x == 0

    output << "#{ys}#{xs}A" unless a.x == 0 && b.y == 3

    output
  end

  def directional_keypad(start, finish)
    button = lambda do |c|
      case c
      when '^' then Point.new(1, 0)
      when '<' then Point.new(0, 1)
      when 'v' then Point.new(1, 1)
      when '>' then Point.new(2, 1)
      when 'A' then Point.new(2, 0)
      else raise "Invalid button: #{c}"
      end
    end

    a = button.call(start)
    b = button.call(finish)
    diff = b - a

    xs = case diff.x <=> 0
         when 1 then '>' * diff.x
         when -1 then '<' * -diff.x
         else ''
         end

    ys = case diff.y <=> 0
         when 1 then 'v' * diff.y
         when -1 then '^' * -diff.y
         else ''
         end

    output = []

    output << "#{xs}#{ys}A" unless a.y == 0 && b.x == 0

    output << "#{ys}#{xs}A" unless a.x == 0 && b.y == 0

    output
  end

  def npad(input, robots)
    acc = 0
    chars = ['A', *input.chars]
    chars.each_cons(2) do |a, b|
      sequences = numeric_keypad(a, b)
      min_sequence = sequences.map { |s| dpad(s, robots) }.min
      acc += min_sequence if min_sequence
    end
    acc
  end

  def dpad(input, robots)
    return @lookup[[input, robots]] if @lookup.key?([input, robots])

    acc = 0
    chars = ['A', *input.chars]
    chars.each_cons(2) do |a, b|
      sequences = directional_keypad(a, b)
      depth = robots - 1

      min_value = if depth > 0
                    sequences.map { |s| dpad(s, depth) }.min
                  else
                    sequences.map(&:length).min
                  end

      acc += min_value if min_value
    end

    @lookup[[input, robots]] = acc
    acc
  end

  def solve(input, robots)
    sum = 0
    input.each_line do |code|
      code.strip!
      numeric_part = code[0...-1].to_i
      sequence_length = npad(code, robots)
      sum += numeric_part * sequence_length
    end
    sum
  end
end

# Example usage and tests
def run_test
  test_input = <<~INPUT
    029A
    980A
    179A
    456A
    379A
  INPUT

  solver = KeypadSolver.new
  result = solver.solve(test_input, 2)
  expected = 126_384

  puts "Test result: #{result}"
  puts "Expected: #{expected}"
  puts "Test #{result == expected ? 'PASSED' : 'FAILED'}"
end

# Run test
run_test

# Process actual input
if __FILE__ == $PROGRAM_NAME
  input = ARGF.read
  solver = KeypadSolver.new
  puts "Part 1 (2 robots): #{solver.solve(input, 2)}"
  puts "Part 2 (25 robots): #{solver.solve(input, 25)}"
end

