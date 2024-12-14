def read_input(filename = 'example_input')
  robots = []
  robot_vector = []

  File.open(filename, 'r') do |file|
    file.each_line do |line|
      parts = line.split(' ')
      p_part = parts[0]
      v_part = parts[1]

      py, px = p_part.split('p=')[1].split(',')
      robots << [px.to_i, py.to_i]

      vy, vx = v_part.split('v=')[1].split(',')
      robot_vector << [vx.to_i, vy.to_i]
    end

    return robots, robot_vector
  end
end
