class Instruction
  def initialize(memory, operand, program_pointer, turn_off_stdout = false)
    @memory = memory
    @operand = operand
    @program_pointer = program_pointer
    @turn_off_stdout = turn_off_stdout
  end

  def execute
    throw 'NotImplementedError'
  end

  protected

  def operand_value
    return @operand unless @is_combo_operand

    return @operand if @operand >= 0 && @operand <= 3

    return @memory.get_register_val('A') if @operand == 4

    return @memory.get_register_val('B') if @operand == 5

    return @memory.get_register_val('C') if @operand == 6

    raise 'Invalid operand'
  end
end
