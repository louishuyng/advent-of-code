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

||||||| parent of 0c7d18e (day11 day 1 advent code 2024)
=======
require './input_reader'
require 'parallel'

def blink_stones(stones)
  stones.each_with_object([]) do |stone, new_stones|
    if stone.zero?
      new_stones << 1
    else
      stone_str = stone.to_s
      if stone_str.length.even?
        half = stone_str.length / 2
        new_stones << stone_str[0...half].to_i
        new_stones << stone_str[half..-1].to_i
      else
        new_stones << stone * 2024
      end
    end
  end
end

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

  # Perform 75 blinks
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
