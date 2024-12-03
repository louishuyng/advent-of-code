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
  input = File.open('input', 'r')

  lines = []

  while line = input.gets
    lines.append(line.strip)
  end

  lines
end

def aggregate_mul_instruction_per_line(line)
  instruction_name = 'mul'
  instruction_param_opening = '('
  instruction_param_closing = ')'
  instruction_separator = ','

  parts = line.split(instruction_name)

  return if parts.empty?

  puts "Parts: #{parts}"

  aggregate = []

  parts.each do |part|
    next if part[0] != instruction_param_opening

    index_of_closing = part.index(instruction_param_closing)
    next if index_of_closing.nil?

    params = part[1..index_of_closing - 1].split(instruction_separator)

    next if params.length != 2
    next if params[0].to_i.zero? || params[0].to_i.to_s.length != params[0].length
    next if params[1].to_i.zero? || params[1].to_i.to_s.length != params[1].length

    aggregate.append([params[0].to_i, params[1].to_i])
  end

  aggregate
end

program
