require './input_reader'
require './moving_robot'

def program
  robot, boxes, walls, movements = read_input('input')

  puts "Robot: #{robot}"
  puts "Boxes: #{boxes}"
  puts "Walls: #{walls}"
  puts "Movements: #{movements}"

  result = moving_robot(robot, walls, boxes, movements)
  new_boxes = result[:new_boxes]

  result = calculate_gps_coordinates(new_boxes)

  puts "Result: #{result}"
end

def calculate_gps_coordinates(new_boxes)
  new_boxes.inject(0) do |acc, box|
    acc + 100 * box[0] + box[1]
  end
end

program
