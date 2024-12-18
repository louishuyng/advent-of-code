require './input_reader'
require './computer'

def program
  register_a, register_b, register_c, program = read_input('input')

  computer = Computer.new

  computer.register('A', register_a)
  computer.register('B', register_b)
  computer.register('C', register_c)

  result = computer.execute(program)

  puts "Result: #{result}"
end

program
