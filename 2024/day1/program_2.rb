def program
  left, right = read_input

  occurrences = build_occurrences_hash(right)

  similarity = []
  left.each do |val|
    similarity.append(val * (occurrences[val] || 0))
  end

  puts "Similarity: #{similarity}"

  # Sum all the distances
  sum = similarity.inject(0, :+)

  puts "Sum: #{sum}"
end

def read_input
  # Read input from file input
  input = File.open('input', 'r')

  left = []
  right = []

  # Read the first line
  while line = input.gets
    # Split the line into two parts
    parts = line.split('  ')

    # Add the first part to the left array
    left.push(parts[0].to_i)

    # Add the second part to the right array
    right.push(parts[1].strip.to_i)
  end

  [left, right]
end

def build_occurrences_hash(list)
  occurrences = {}

  list.each do |val|
    if occurrences.key?(val)
      occurrences[val] += 1
    else
      occurrences[val] = 1
    end
  end

  occurrences
end

program
