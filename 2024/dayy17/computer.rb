require './instructions/factory'
require './register'
require './memory'
require './program_pointer'

class Computer
  attr_reader :memory, :program_pointer

  def initialize
    @register_a = Register.new('A', 0)
    @register_b = Register.new('B', 0)
    @register_c = Register.new('C', 0)
    @program_pointer = ProgramPointer.new
    @program = []
  end

  def register(type, value)
    case type
    when 'A'
      @register_a = Register.new(type, value)
    when 'B'
      @register_b = Register.new(type, value)
    when 'C'
      @register_c = Register.new(type, value)
    end
  end

  def execute(program)
    stdout = []

    init_memory_and_program(program)

    puts "Loaded program: #{@program}"

    while @program_pointer.cursor < @program.length - 1
      instruction = current_instruction
      @program_pointer.increment
      operand = current_instruction

      new_memory, new_pointer, out = InstructionFactory.new.execute(
        instruction,
        operand,
        @memory,
        @program_pointer
      )

      stdout << out if out

      @memory = new_memory
      @program_pointer = new_pointer
    end

    stdout.join(',')
  end

  private

  def current_instruction
    @program[@program_pointer.cursor]
  end

  def init_memory_and_program(program)
    @memory = Memory.new(@register_a, @register_b, @register_c)
    @program = program
  end
end
