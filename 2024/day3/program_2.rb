require './get_next_param_number'

def program
  lines = read_input

  total = 0
  lines.each do |line|
    mul_instructions = aggregate_mul_instruction_per_line(line)

    # Process mul instructions
    mul_instructions.each do |mul_instruction|
      total += mul_instruction[0] * mul_instruction[1]
    end
  end

  puts "Total: #{total}"
end

def read_input
  # Read input from file input
  # input = File.open('example_input_2', 'r')
  input = File.open('input', 'r')

  lines = []

  while line = input.gets
    lines.append(line.strip)
  end

  lines
end

def aggregate_mul_instruction_per_line(line)
  instruction_name = 'mul'

  aggregate = []
  current_index = 0

  enabled = true

  while current_index < line.length
    if line[current_index, 7] == "don't()"
      enabled = false
      current_index += 7
      next
    end

    if line[current_index, 4] == 'do()'
      enabled = true
      current_index += 4
      next
    end

    unless enabled
      current_index += 1
      next
    end

    unless line[current_index, instruction_name.length] == instruction_name
      current_index += 1
      next
    end

    current_index += instruction_name.length

    param1, param2, next_index = get_next_param_number(line, current_index)

    if param1.nil? || param2.nil?
      current_index = next_index
      next
    end

    aggregate.append([param1, param2])
    current_index = next_index
  end

  aggregate
end

program
