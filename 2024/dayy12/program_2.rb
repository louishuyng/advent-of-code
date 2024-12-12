require './input_reader'
require './find_area_positions'
require './calculate_area'
require './calculate_side'

def program
  garden = read_input('input')

  puts "Garden: #{garden}"

  area_positions = find_area_positions(garden)
  puts "Area positions: #{area_positions}"

  price = 0
  area_positions.each do |area_position|
    puts "Calculate price for are #{area_position[:name]}"

    area = calculate_area(area_position[:positions])
    side = calculate_side(area_position[:positions])
    puts "Price: #{area} * #{side}"

    price += area * side
    puts '===================='
  end

  puts "Price: #{price}"
end

program
