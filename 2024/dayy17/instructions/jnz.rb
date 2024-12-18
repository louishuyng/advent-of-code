require_relative 'base'

class JnzInstruction < Instruction
  def initialize(memory, operand, program_pointer)
    @name = 'jnz'
    @is_combo_operand = false

    super
  end

  def execute
    puts 'Executing jnz instruction'

    return [@memory, @program_pointer.increment] if @memory.get_register_val('A').zero?

    [@memory, @program_pointer.set(operand_value)]
  end
end
