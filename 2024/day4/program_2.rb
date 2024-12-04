def program
  lines = read_input
  matched_words = []

  rows = lines.length
  cols = lines[0].length

  (0...rows).each do |row|
    (0...cols).each do |col|
      matched_words << find_match_word(lines, row, col) # Corrected parameter order
    end
  end

  matched_words = matched_words.flatten(1)

  puts "Found: #{matched_words.length}"
end

def read_input
  lines = []

  # Using a block to ensure the file is closed automatically
  File.open('input', 'r') do |input|
    while line = input.gets
      lines.append(line.strip)
    end
  end

  lines
end

def find_match_word(lines, row, col)
  occurrences = []

  occurrences.append([row, col]) if match?(lines, row, col)

  occurrences
end

def match?(lines, row, col)
  current_char = lines[row][col]

  return false if current_char != 'A'

  return false if col - 1 < 0 || row - 1 < 0
  return false if row + 1 >= lines.length || col + 1 >= lines[0].length

  top_left_char = lines[row - 1][col - 1]
  top_right_char = lines[row - 1][col + 1]
  bottom_left_char = lines[row + 1][col - 1]
  bottom_right_char = lines[row + 1][col + 1]

  combine_chars_diagonal_one = [top_left_char, bottom_right_char].join
  combine_chars_diagonal_two = [top_right_char, bottom_left_char].join

  allow_words = %w[MS SM]

  return false unless allow_words.include?(combine_chars_diagonal_one)
  return false unless allow_words.include?(combine_chars_diagonal_two)

  true
end

program
