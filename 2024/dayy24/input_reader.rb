def read_input(file_name)
  wires = {}

  output_wires = {}

  File.open(file_name, 'r') do |file|
    file.each_line do |line|
      if line.include?(':')
        wire, signal = line.split(':').map(&:strip)
        wires[wire] = signal.to_i
        next
      end

      next unless line.include?('->')

      instruction, output_wire = line.split('->').map(&:strip)

      input_one, gate, input_two = instruction.split(' ')

      output_wires[output_wire] = [input_one, gate, input_two]
    end
  end

  [wires, output_wires]
end
