require 'rspec/autorun'
require './program_2'

describe '#aggregate_mul_instruction_per_line' do
  it('returns an empty array when there are no mul instructions') do
    aggregate = aggregate_mul_instruction_per_line('add 1 2')

    expect(aggregate).to eq([])
  end

  it('returns an array with one element when there is one mul instruction') do
    aggregate = aggregate_mul_instruction_per_line('add mul(1,2) asad')

    expect(aggregate).to eq([[1, 2]])
  end

  it('when include dont instruction, it returns an empty array') do
    aggregate = aggregate_mul_instruction_per_line('add don\'t() mul(1,2) asad')

    expect(aggregate).to eq([])
  end

  it("when include don't instruction, but re enable by do() instruction, it returns an array with one element") do
    aggregate = aggregate_mul_instruction_per_line('add don\'t() mul(3,4) do() mul(1,2) asad')

    expect(aggregate).to eq([[1, 2]])
  end

  it('complex case') do
    aggregate = aggregate_mul_instruction_per_line("<mul(813,338)! +$what()<don't(){^mul(396,693)mul(337,541)}what()*<](@?~mul(64,644)[where()who()~,))mul(528,450)!' -do()who()#]where():(mul(909,368)mul(259,743)")

    expect(aggregate).to eq([[813, 338], [909, 368], [259, 743]])
  end
end
