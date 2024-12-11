def evolve_stones(stones, blinks)
  # Use a Hash to count occurrences of each stone
  stone_counts = Hash.new(0)

  # Initialize the stone counts
  stones.each do |stone|
    stone_counts[stone] += 1
  end

  # Simulate the evolution for the specified number of blinks
  blinks.times do
    new_stone_counts = Hash.new(0)

    # Process each stone in the current counts
    stone_counts.each do |stone, count|
      if stone.zero?
        # Rule 1: 0 becomes 1
        new_stone_counts[1] += count
      elsif stone.to_s.length.even?
        # Rule 2: Split the stone into two
        str_stone = stone.to_s
        mid = str_stone.length / 2
        left = str_stone[0...mid].to_i
        right = str_stone[mid..].to_i
        new_stone_counts[left] += count
        new_stone_counts[right] += count
      else
        # Rule 3: Multiply the stone by 2024
        new_stone = stone * 2024
        new_stone_counts[new_stone] += count
      end
    end

    # Update the stone counts for the next blink
    stone_counts = new_stone_counts
  end

  # Calculate the total number of stones after all blinks
  stone_counts.values.sum

  # Return the final count of stones
end
