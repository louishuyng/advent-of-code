require 'rspec/autorun'
require './computer'

describe 'Test computer running' do
  describe 'Test 1' do
    it 'should return correct result' do
      computer = Computer.new

      computer.register('C', 9)

      run_program(computer, '2,6')

      expect(computer.memory.get_register_val('B')).to eq(1)
    end
  end

  describe 'Test 2' do
    it 'should return correct result' do
      computer = Computer.new

      computer.register('A', 10)

      output = run_program(computer, '5,0,5,1,5,4')

      expect(output).to eq('0,1,2')
    end
  end

  describe 'Test 3' do
    it 'should return correct result' do
      computer = Computer.new

      computer.register('A', 2024)

      output = run_program(computer, '0,1,5,4,3,0')

      expect(output).to eq('4,2,5,6,7,7,7,7,3,1,0')
      expect(computer.memory.get_register_val('A')).to eq(0)
    end
  end

  describe 'Test 4' do
    it 'should return correct result' do
      computer = Computer.new

      computer.register('B', 29)

      run_program(computer, '1,7')
      expect(computer.memory.get_register_val('B')).to eq(26)
    end
  end

  describe 'Test 5' do
    it 'should return correct result' do
      computer = Computer.new

      computer.register('B', 2024)
      computer.register('C', 43_690)

      run_program(computer, '4,0')

      expect(computer.memory.get_register_val('B')).to eq(44_354)
    end
  end

  def run_program(computer, program)
    computer.execute(program.split(',').map(&:to_i))
  end
end
