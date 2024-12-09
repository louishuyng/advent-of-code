require './input_reader'
require './move_file_block'
require './gap_check'

def program
  spaces = read_input
  puts "Spaces: #{spaces}"

  spaces = move_file_block_from_end_to_free_left(spaces) while has_gap_between_file_blocks(spaces)

  puts "Spaces After Move: #{spaces}"

  check_sum = calculate_check_sum(spaces)

  puts "Check Sum: #{check_sum}"
end

def calculate_check_sum(spaces)
  # get only number in spaces
  numbers = []

  spaces.each do |space|
    numbers << space if space != '.'
  end

  total = 0
  numbers.each_with_index do |num, index|
    total += num * index
  end

  total
end

program
