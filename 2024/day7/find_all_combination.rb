def find_all_combination(n, support_operations = %i[add multiply], start = 1, stack = [],
                         result = [])
  if stack.size == n
    result.push(stack.dup)
    return result
  end

  (start..n).each do |i|
    support_operations.each do |operation|
      stack << operation
      result = find_all_combination(
        n, support_operations, i + 1, stack, result
      )
      stack.pop
    end
  end

  result
end
