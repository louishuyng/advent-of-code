def get_antinodes_by_antennas(ante1, ante2, boundary)
  antinodes = if same_line_horizontal?(ante1, ante2)
                get_antinodes_horizontal(ante1, ante2, boundary)
              elsif same_line_vertical?(ante1, ante2)
                get_antinodes_vertical(ante1, ante2, boundary)
              else
                get_antinodes_diagonal(ante1, ante2, boundary)
              end

  antinodes.reject { |ante| antinode_out_boundary?(ante, boundary) }
end

def same_line_horizontal?(ante1, ante2)
  ante1[0] == ante2[0]
end

def same_line_vertical?(ante1, ante2)
  ante1[1] == ante2[1]
end

def get_antinodes_horizontal(ante1, ante2, boundary)
  left_list = []
  right_list = []

  smaller_ante = ante1[1] < ante2[1] ? ante1 : ante2
  bigger_ante = ante1[1] < ante2[1] ? ante2 : ante1

  distance = bigger_ante[1] - smaller_ante[1]

  left_count = 1
  while smaller_ante[1] - left_count * distance >= 0
    left_list << [ante1[0], smaller_ante[1] - distance * left_count]
    count += 1
  end

  right_count = 1
  while bigger_ante[1] + right_count * distance < boundary[1]
    right_list << [ante1[0], bigger_ante[1] + distance * right_count]
    right_count += 1
  end

  left_list + right_list
end

def get_antinodes_vertical(ante1, ante2, boundary)
  left_list = []
  right_list = []

  smaller_ante = ante1[0] < ante2[0] ? ante1 : ante2
  bigger_ante = ante1[0] < ante2[0] ? ante2 : ante1

  distance = bigger_ante[0] - smaller_ante[0]

  left_count = 1
  while smaller_ante[0] - left_count * distance >= 0
    left_list << [smaller_ante[0] - distance * left_count, ante1[1]]
    left_count += 1
  end

  right_count = 1
  while bigger_ante[0] + right_count * distance < boundary[0]
    right_list << [bigger_ante[0] + distance * right_count, ante1[1]]
    right_count += 1
  end

  left_list + right_list
end

def get_antinodes_diagonal(ante1, ante2, boundary)
  left_list = []
  right_list = []

  smaller_ante = ante1[0] < ante2[0] ? ante1 : ante2
  bigger_ante = ante1[0] < ante2[0] ? ante2 : ante1

  distance_x = bigger_ante[0] - smaller_ante[0]
  distance_y = bigger_ante[1] - smaller_ante[1]

  left_count = 1
  while smaller_ante[0] - left_count * distance_x >= 0 && smaller_ante[1] - left_count * distance_y >= 0
    left_list << [smaller_ante[0] - distance_x * left_count, smaller_ante[1] - distance_y * left_count]
    left_count += 1
  end

  right_count = 1
  while bigger_ante[0] + right_count * distance_x < boundary[0] && bigger_ante[1] + right_count * distance_y < boundary[1]
    right_list << [bigger_ante[0] + distance_x * right_count, bigger_ante[1] + distance_y * right_count]
    right_count += 1
  end

  left_list + right_list
end

def antinode_out_boundary?(ante, boundary)
  if ante[0].negative? || ante[1].negative?
    true
  elsif ante[0] > boundary[0] - 1 || ante[1] > boundary[1] - 1
    true
  else
    false
  end
end
