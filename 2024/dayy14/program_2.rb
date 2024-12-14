require 'set'
require './input_reader'
require './moving_bot'

def program
  input = read_input('input')

  robots = input[0]
  robot_vector = input[1]
  total_robots = robots.size

  titles = [103, 101] # Assuming these are some identifiers for the robots

  seconds = 0

  loop do
    seconds += 1
    puts "Seconds: #{seconds}"

    set = Set.new
    new_robots = []

    robots.each_with_index do |robot, index|
      # Assuming moving_bot is a method that returns the new position of the robot
      new_robot = moving_bot(robot, robot_vector[index], titles, 1)

      set.add(new_robot)
      new_robots << new_robot
    end

    if set.size == total_robots
      puts "All robots have collided at #{seconds} seconds"
      break
    end

    robots = new_robots
  end
end

program
