require_relative 'base'

class CdvInstruction < Instruction
  def initialize(memory, operand, program_pointer)
    @name = 'cdv'
    @is_combo_operand = true

    super
  end

  def execute
    puts 'Executing cdv instruction'

    numberator = @memory.get_register_val('A')

    @memory.overwrite_register('C', (numberator / 2.pow(operand_value)))

    [@memory, @program_pointer.increment]
  end
end
