require 'parallel'
require './input_reader'
require './blink'

def process_stones_batch(stones, cache)
  # Process a batch of stones and cache results
  results = []
  stones.each do |stone|
    if cache.key?(stone)
      results << cache[stone]
    else
      result = blink_stones([stone]) # Process stone
      cache[stone] = result
      results << result
    end
  end
  results.flatten
end

def program
  stones = read_input('input')
  cache = {}

  75.times do |i|
    puts "Blinking stones #{i + 1} time(s)"

    # Use Parallel to process stones in batches
    stones = Parallel.map(stones.each_slice(1000).to_a, in_processes: 16) do |stone_batch|
      process_stones_batch(stone_batch.flatten, cache)
    end.flatten
  end

  length = stones.length
  puts "Final stones: #{length}"
end

program

