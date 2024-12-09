require './input_reader'
require './move_files_block'

def program
  spaces = read_input
  puts "Spaces: #{spaces}"
  max_id = find_max_id_in_spaces(spaces)
  puts "Max ID: #{max_id}"

  max_id.downto(0) do |id|
    puts "Moving block of space_id #{id} to free left"
    new_space = move_files_block_to_free_left(spaces, id)
    puts '====================='
    spaces = new_space if new_space
  end

  check_sum = calculate_check_sum(spaces)

  puts "Check sum: #{check_sum}"
end

def find_max_id_in_spaces(spaces)
  spaces.reverse.each do |space|
    return space if space != '.'
  end
end

def calculate_check_sum(spaces)
  # get only number in spaces
  numbers = []

  spaces.each do |space|
    numbers << space
  end

  total = 0
  numbers.each_with_index do |num, index|
    next if num == '.'

    total += num * index
  end

  total
end

program
