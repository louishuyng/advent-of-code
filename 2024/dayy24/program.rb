require './input_reader'

def solve_output_wires(output_wires, wires)
  output_wires.each do |wire, value|
    # If the output wire is an array then need to solve it
    if value.is_a?(Array)
      _, new_output_wires = solve_single_output_wire(wire, output_wires, wires)
      output_wires.merge!(new_output_wires)
    end
  end

  sorted_output_wires = output_wires.sort_by { |wire, _| wire }
  puts "Sorted output wires: #{sorted_output_wires}"

  # Combining the bits from all wires starting with z produces the binary number
  found_binary = sorted_output_wires.select { |wire, _| wire.start_with?('z') }.map { |_, value| value }.join.reverse
  puts "Found binary: #{found_binary}"
  final_number = found_binary.to_i(2)
  puts "Final number: #{final_number}"
end

def solve_single_output_wire(wire, output_wires, wires)
  return output_wires[wire], output_wires unless output_wires[wire].is_a?(Array)

  new_output_wires = output_wires.dup

  first_wire, operator, second_wire = output_wires[wire]

  value_first_wire = nil
  value_second_wire = nil

  if wires[first_wire]
    value_first_wire = wires[first_wire]
  else
    value_first_wire, new_output_wires = solve_single_output_wire(first_wire, output_wires, wires)
  end

  if wires[second_wire]
    value_second_wire = wires[second_wire]
  else
    value_second_wire, new_output_wires = solve_single_output_wire(second_wire, output_wires, wires)
  end

  case operator
  when 'AND'
    new_output_wires[wire] = value_first_wire & value_second_wire
  when 'OR'
    new_output_wires[wire] = value_first_wire | value_second_wire
  when 'XOR'
    new_output_wires[wire] = value_first_wire ^ value_second_wire
  end

  [new_output_wires[wire], new_output_wires]
end

wires, output_wires = read_input('input')

solve_output_wires(output_wires, wires)
