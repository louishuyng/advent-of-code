def read_input
  # filename = 'example_input'
  filename = 'input'

  spaces = []

  File.open(filename, 'r') do |file|
    is_block = true
    id = 0

    file.each_line do |line|
      line.strip.each_char do |char|
        total_block = char.to_i

        total_block.times do
          spaces << (is_block ? id : '.')
        end

        if is_block
          is_block = false
          id += 1
        else
          is_block = true
        end
      end
    end
  end

  spaces
end
