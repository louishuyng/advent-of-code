require_relative 'base'

class OutInstruction < Instruction
  def initialize(memory, operand, program_pointer)
    @name = 'out'
    @is_combo_operand = true

    super
  end

  def execute
    puts 'Executing out instruction'

    output = operand_value % 8

    [@memory, @program_pointer.increment, output]
  end
end
