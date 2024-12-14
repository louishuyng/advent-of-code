require './input_reader'
require './moving_bot'
require './separate_squad'

def program
  input = read_input('input')
  robots = input[0]
  robot_vector = input[1]
  # titles = [7, 11]
  titles = [103, 101]

  # Do something with the input
  puts "Robots: #{robots}"
  puts "Robot vectors: #{robot_vector}"

  render_map_view(titles, robots)

  new_robots = []

  robots.each_with_index do |robot, index|
    new_robots << moving_bot(robot, robot_vector[index], titles, 100)
  end

  puts "new robots: #{new_robots}"

  puts 'After 100 seconds'
  render_map_view(titles, new_robots)

  squads = separate_squad(new_robots, titles)

  safety_factor = squads.inject(1) do |multiple, squad|
    multiple * squad.count
  end

  puts "Safety factor: #{safety_factor}"
end

def render_map_view(titles, robots)
  puts '======Map View========'
  row = titles[0]
  column = titles[1]

  for i in 0..row - 1
    queue = []
    for j in 0..column - 1
      unless robots.include?([i, j])
        queue << '.'
        next
      end

      number_elements = robots.select { |robot| robot == [i, j] }.count

      queue << number_elements
    end

    puts queue.join(' ')
  end

  puts '====================='
end

program
