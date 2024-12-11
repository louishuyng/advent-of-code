require './input_reader'
require './evolve_stones'

def program
  # Example usage
  initial_stones = read_input('input')
  number_of_blinks = 75
  result = evolve_stones(initial_stones, number_of_blinks)

  puts "Number of stones after #{number_of_blinks} blinks: #{result}"
end

program
