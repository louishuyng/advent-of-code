def read_input
  current_position = nil
  current_direction = nil
  row = 0

  obstacles = []

  # filename = 'example_input'
  filename = 'input'

  File.open(filename, 'r') do |file|
    file.each_line.with_index do |line, index|
      row += 1
      obstacles[index] = []

      line.each_char.with_index do |char, char_index|
        obstacles[index] << char_index if char == '#'

        current_position = [index, char_index] if ['^', '>', 'v', '<'].include?(char)

        case char
        when '^'
          current_direction = :up
        when '>'
          current_direction = :right
        when 'v'
          current_direction = :down
        when '<'
          current_direction = :left
        end
      end
    end
  end

  [row, current_position, current_direction, obstacles]
end
