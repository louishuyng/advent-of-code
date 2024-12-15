def read_input(filename = 'example_input')
  robot = []
  boxes = []
  walls = []
  movements = []

  map_reading = true

  File.open(filename, 'r') do |file|
    file.each_line.with_index do |line, row|
      if line.strip.empty?
        map_reading = false
        next
      end

      if map_reading
        line.each_char.with_index do |char, column|
          case char
          when '#'
            walls << [row, column]
          when 'O'
            boxes << [row, column]
          when '@'
            robot = [row, column]
          end
        end
      else
        line.each_char do |char|
          case char
          when '^'
            movements << :up
          when 'v'
            movements << :down
          when '<'
            movements << :left
          when '>'
            movements << :right
          end
        end
      end
    end
  end

  return robot, boxes, walls, movements
end
