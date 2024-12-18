require './input_reader'
require './computer'

def program
  _, register_b, register_c, program = read_input('input')

  original_program_str = program.join(',')
  puts "Original program: #{original_program_str}"

  result = ''
  register_a = 0

  until result == original_program_str
    puts "Trying register A: #{register_a}"
    computer = Computer.new
    computer.register('A', register_a)
    computer.register('B', register_b)
    computer.register('C', register_c)

    result = computer.execute(program, turn_off_stdoutt: true)

    register_a += 1
  end
end

program
