require_relative 'base'

class BdvInstruction < Instruction
  def initialize(memory, operand, program_pointer)
    @name = 'bdv'
    @is_combo_operand = true

    super
  end

  def execute
    puts 'Executing bdv instruction'

    numberator = @memory.get_register_val('A')

    @memory.overwrite_register('B', (numberator / 2.pow(operand_value)))

    [@memory, @program_pointer.increment]
  end
end
