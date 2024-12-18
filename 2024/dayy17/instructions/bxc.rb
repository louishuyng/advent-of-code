require_relative 'base'

class BxcInstruction < Instruction
  def initialize(memory, operand, program_pointer)
    @name = 'bxc'
    @is_combo_operand = false

    super
  end

  def execute
    puts 'Executing bxc instruction'

    register_c_value = @memory.get_register_val('C')
    register_b_value = @memory.get_register_val('B')

    @memory.overwrite_register('B', xor(register_c_value, register_b_value))

    [@memory, @program_pointer.increment]
  end

  def xor(a, b)
    a ^ b
  end
end
