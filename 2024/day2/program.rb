def program
  lines = read_input

  puts "Lines: #{lines}"
  puts "Total Lines: #{lines.length}"

  safeLines = 0

  lines.each do |line|
    safeLines += 1 if check_line_safe(line)
  end

  puts "Safe Lines: #{safeLines}"
end

def read_input
  # Read input from file input
  input = File.open('input', 'r')

  lines = []

  while line = input.gets
    parts = line.split(' ')
    lines.append(parts.map(&:to_i))
  end

  lines
end

def check_line_safe(line)
  increase_flag = false

  if line[0] < line[1]
    increase_flag = true
  elsif line[0] > line[1]
    increase_flag = false
  end

  for i in 0..line.length - 2
    if increase_flag
      return false if line[i] > line[i + 1]

      return false if line[i + 1] - line[i] < 1 || line[i + 1] - line[i] > 3
    else
      return false if line[i] < line[i + 1]

      return false if line[i] - line[i + 1] < 1 || line[i] - line[i + 1] > 3
    end
  end

  true
end

program
