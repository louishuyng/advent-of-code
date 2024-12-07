def find_all_combination(n, start = 1, stack = [], result = [])
  if stack.size == n
    result.push(stack.dup)
    return result
  end

  (start..n).each do |i|
    stack << :add
    result = find_all_combination(n, i + 1, stack, result)
    stack.pop

    stack << :multiply
    result = find_all_combination(n, i + 1, stack, result)
    stack.pop
  end

  result
end
