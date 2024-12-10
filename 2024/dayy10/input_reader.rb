def read_input(filename = 'example_input')
  map = []
  start_positions = []

  File.open(filename, 'r') do |file|
    file.each_line.with_index do |line, x|
      map[x] = []

      line.strip.chars.each_with_index do |char, y|
        case char
        when '0'
          start_positions << [x, y]
        end

        map[x][y] = char
      end
    end
  end

  [map, start_positions]
end
