require_relative 'base'

class BxlInstruction < Instruction
  def initialize(memory, operand, program_pointer, turn_off_stdout = false)
    @name = 'bxl'
    @is_combo_operand = false

    super
  end

  def execute
    puts 'Executing bxl instruction' unless @turn_off_stdout

    register_b_val = @memory.get_register_val('B')

    @memory.overwrite_register('B', xor(register_b_val, operand_value))

    [@memory, @program_pointer.increment]
  end

  def xor(a, b)
    a ^ b
  end
end
