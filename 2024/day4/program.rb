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

  directions = [
    [-1, 0],  # up
    [0, 1],   # right
    [1, 0],   # down
    [0, -1],  # left
    [-1, -1], # up-left diagonal
    [1, 1],   # down-right diagonal
    [1, -1],  # down-left diagonal
    [-1, 1]   # up-right diagonal
  ]

  directions.each do |direction|
    if match?(lines, row, col, "XMAS", direction)
      occurrences.append([row, col])
    end
  end

  occurrences
end

def match?(lines, row, col, match_word, direction)
  max_row = lines.length
  max_col = lines[0].length

  (0...match_word.length).each do |i|
    new_row = row + direction[0] * i
    new_col = col + direction[1] * i
    
    return false if new_row < 0 || new_row >= max_row || new_col < 0 || new_col >= max_col || lines[new_row][new_col] != match_word[i]
  end

  true
end

program

