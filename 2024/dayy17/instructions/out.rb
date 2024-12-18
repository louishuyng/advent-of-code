require_relative 'base'

class OutInstruction < Instruction
  def initialize(memory, operand, program_pointer, turn_off_stdout = false)
    @name = 'out'
    @is_combo_operand = true

    super
  end

  def execute
    puts 'Executing out instruction' unless @turn_off_stdout

    output = operand_value % 8

    [@memory, @program_pointer.increment, output]
  end
end
