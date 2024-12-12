def read_input(filename = 'example_input')
  garden = []
  File.open(filename, 'r') do |file|
    file.each_line.with_index do |line, i|
      garden[i] = []

      line.chomp.each_char.with_index do |char, j|
        garden[i][j] = char
      end
    end
  end

  garden
end
