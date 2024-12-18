require_relative 'base'

class BstInstruction < Instruction
  def initialize(memory, operand, program_pointer)
    @name = 'bst'
    @is_combo_operand = true

    super
  end

  def execute
    puts 'Executing bst instruction'

    @memory.overwrite_register('B', operand_value % 8)

    [@memory, @program_pointer.increment]
  end
end
