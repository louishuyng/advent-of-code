def program()
  left, right = read_input()

  # Sort from smallest to largest
  sorted_left = left.sort
  sorted_right = right.sort

  puts "Sorted Left: #{sorted_left}"
  puts "Sorted Right: #{sorted_right}"

  distance = []
  sorted_left.each_with_index do |val, index|
    distance.append((sorted_right[index] - val).abs)
  end

  puts "Distance: #{distance}"

  # Sum all the distances
  sum = distance.inject(0, :+)

  puts "Sum: #{sum}"
end

def read_input()
  # Read input from file input
  input = File.open("input", "r")

  left = []
  right = []

  # Read the first line
  while line = input.gets
    # Split the line into two parts
    parts = line.split("  ")

    # Add the first part to the left array
    left.push(parts[0].to_i)

    # Add the second part to the right array
    right.push(parts[1].strip.to_i)
  end

  return left, right
end

program()
