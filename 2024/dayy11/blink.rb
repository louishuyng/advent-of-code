def blink_stones(stones)
  stones.each_with_object([]) do |stone, new_stones|
    if stone.zero?
      new_stones << 1
    else
      stone_str = stone.to_s
      if stone_str.length.even?
        half = stone_str.length / 2
        new_stones << stone_str[0...half].to_i
        new_stones << stone_str[half..].to_i
      else
        new_stones << stone * 2024
      end
    end
  end
end
