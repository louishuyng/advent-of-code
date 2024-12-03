def program
  lines = read_input

  puts "Lines: #{lines}"
  puts "Total Lines: #{lines.length}"

  safe_lines = 0

  lines.each do |line|
    safe_lines += 1 if check_line_safe(line)
  end

  puts "Safe Lines: #{safe_lines}"
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

def check_line_safe(line, with_tolerance = true)
  increase_flag = false
  check_tolerance_with_position = nil

  if line[0] < line[1]
    increase_flag = true
  elsif line[0] > line[1]
    increase_flag = false
  end

  for i in 0..line.length - 2
    has_fail = if increase_flag
                 (line[i] > line[i + 1]) || (line[i + 1] - line[i] < 1 || line[i + 1] - line[i] > 3)

               else
                 (line[i] < line[i + 1]) || (line[i] - line[i + 1] < 1 || line[i] - line[i + 1] > 3)
               end

    return false if has_fail && !with_tolerance

    if has_fail && with_tolerance
      check_tolerance_with_position = i
      break
    end
  end

  if check_tolerance_with_position
    new_line_deleted_at_i = line.dup
    new_line_deleted_at_i.delete_at(check_tolerance_with_position)

    new_line_deleted_at_i_plus_one = line.dup
    new_line_deleted_at_i_plus_one.delete_at(check_tolerance_with_position + 1)

    new_line_deleted_at_i_minus_one = line.dup
    new_line_deleted_at_i_minus_one.delete_at(check_tolerance_with_position - 1)

    if check_line_safe(new_line_deleted_at_i, false)
      return true
    elsif check_line_safe(new_line_deleted_at_i_plus_one, false)
      return true
    elsif check_line_safe(new_line_deleted_at_i_minus_one, false)
      return true
    else
      return false
    end
  end

  true
end

program
