def read_input(file_name = 'example_input')
  register_a = nil
  register_b = nil
  register_c = nil

  program = []

  File.open(file_name).each do |file|
    file.each_line do |line|
      if line.include?('Register A')
        register_a = line.split('Register A: ')[1].to_i
      elsif line.include?('Register B')
        register_b = line.split('Register B: ')[1].to_i
      elsif line.include?('Register C')
        register_c = line.split('Register C: ')[1].to_i
      elsif line.include?('Program')
        program = line.split('Program: ')[1].split(',').map(&:to_i)
      end
    end
  end

  [register_a, register_b, register_c, program]
end
