def read_input(filename = 'example_input')
  stones = []
  File.open(filename, 'r') do |file|
    file.each_line do |line|
      line.chomp.split(' ').each do |stone|
        stones << stone.to_i
      end
    end
  end

  stones
end
