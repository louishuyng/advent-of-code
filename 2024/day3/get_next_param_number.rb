def get_next_param_number(line, current)
  return [nil, nil, current] if line[current] != '('

  current += 1

  # If not start with number then return nil
  return [nil, nil, current + 1] if line[current].to_i.zero?

  # Find first number
  stack = []

  firstNumber = nil
  while current < line.length
    return [nil, nil, current + 1] if !char_number?(line[current]) && line[current] != ','

    return [nil, nil, current + 1] if line[current] == ',' && stack.empty?

    if line[current] == ','
      firstNumber = stack.join.to_i
      stack = []
      current += 1
      break
    end

    stack.append(line[current]) if char_number?(line[current])

    current += 1
  end

  return [nil, nil, current + 1] if firstNumber.nil?

  stack = []
  # Find second number
  secondNumber = nil
  while current < line.length
    return [nil, nil, current + 1] if !char_number?(line[current]) && line[current] != ')'

    return [nil, nil, current + 1] if line[current] == ')' && stack.empty?

    if line[current] == ')'
      secondNumber = stack.join.to_i
      stack = []
      current += 1
      break
    end

    stack.append(line[current]) if char_number?(line[current])

    current += 1
  end

  return [nil, nil, current + 1] if secondNumber.nil?

  [firstNumber, secondNumber, current]
end

def char_number?(char)
  char.to_i.to_s == char
end

