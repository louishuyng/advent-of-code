keys = []
pins = []

key_number = -1
pin_number = -1
row = 0
is_pin = true

File.read('input').each_line do |line|
  if line.chomp == ''
    row = 0
    next
  end

  line.chomp.split('').each_with_index do |char, column|
    if row.zero? && column.zero?
      is_pin = char == '#'

      if is_pin
        pin_number += 1
        pins[pin_number] ||= []
      else
        key_number += 1
        keys[key_number] ||= []
      end
    end

    if is_pin
      pins[pin_number][row] ||= []
      pins[pin_number][row][column] = char
    else
      keys[key_number][row] ||= []
      keys[key_number][row][column] = char
    end
  end

  row += 1
end

puts "Keys: #{keys.size}"
puts "Pins: #{pins.size}"

def find_heights(pins)
  column_count = Array.new(pins[0].length, 0)

  pins.each do |row|
    row.each_with_index do |char, column|
      column_count[column] += 1 if char == '#'
    end
  end

  column_count.map { |count| count == 0 ? 0 : count - 1 }
end

def fit?(key_h, pin_h, max_height)
  for i in 0..key_h.length - 1
    if key_h[i] + pin_h[i] >= max_height
      return false
    end
  end

  true
end

max_height = keys[0].length - 1
key_heights = keys.map { |key| find_heights(key) }
pin_heights = pins.map { |pin| find_heights(pin) }

# Find unique pins keys that fit
count = 0
key_heights.each do |key_h|
  pin_heights.each do |pin_h|
    if fit?(key_h, pin_h, max_height)
      count += 1
    end
  end
end


puts "Count: #{count}"
