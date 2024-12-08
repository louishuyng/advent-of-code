def read_input
  # filename = 'example_input'
  filename = 'input'

  antennas = {}
  boundary = []

  File.open(filename, 'r') do |file|
    file.each_line.with_index do |line, index|
      boundary[0] = 0 unless boundary[0]
      boundary[0] += 1
      boundary[1] = line.strip.size unless boundary[1]

      line.strip.each_char.with_index do |char, i|
        next if ['.'].include?(char)

        antennas[char] = [] unless antennas[char]

        antennas[char] << [index, i]
      end
    end
  end

  [antennas, boundary]
end
