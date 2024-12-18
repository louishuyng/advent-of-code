require_relative 'base'

class JnzInstruction < Instruction
  def initialize(memory, operand, program_pointer, turn_off_stdout = false)
    @name = 'jnz'
    @is_combo_operand = false

    super
  end

  def execute
    puts 'Executing jnz instruction' unless @turn_off_stdout

    return [@memory, @program_pointer.increment] if @memory.get_register_val('A').zero?

    [@memory, @program_pointer.set(operand_value)]
  end
end
