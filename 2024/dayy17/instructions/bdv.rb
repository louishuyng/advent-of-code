require_relative 'base'

class BdvInstruction < Instruction
  def initialize(memory, operand, program_pointer, turn_off_stdout = false)
    @name = 'bdv'
    @is_combo_operand = true

    super
  end

  def execute
    puts 'Executing bdv instruction' unless @turn_off_stdout

    numberator = @memory.get_register_val('A')

    @memory.overwrite_register('B', (numberator / 2.pow(operand_value)))

    [@memory, @program_pointer.increment]
  end
end
