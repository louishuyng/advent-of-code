require_relative 'base'

class AdvInstruction < Instruction
  def initialize(memory, operand, program_pointer)
    @name = 'adv'
    @is_combo_operand = true

    super
  end

  def execute
    puts 'Executing adv instruction'

    numberator = @memory.get_register_val('A')

    @memory.overwrite_register('A', (numberator / 2.pow(operand_value)))

    [@memory, @program_pointer.increment]
  end
end
