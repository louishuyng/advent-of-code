require './input_reader'
require './find_trail_head_score'

def program
  map, start_positions = read_input('input')

  puts "Map: #{map}"
  puts "Start positions: #{start_positions}"

  scores = find_trail_head_score(map, start_positions, false)

  puts "Scores: #{scores}"
end

program
