def get_antinodes_by_antennas(ante1, ante2, boundary)
  antinodes = if same_line_horizontal?(ante1, ante2)
                get_antinodes_horizontal(ante1, ante2)
              elsif same_line_vertical?(ante1, ante2)
                get_antinodes_vertical(ante1, ante2)
              else
                get_antinodes_diagonal(ante1, ante2)
              end

  [
    antinode_out_boundary?(antinodes[0], boundary) ? nil : antinodes[0],
    antinode_out_boundary?(antinodes[1], boundary) ? nil : antinodes[1]
  ]
end

def same_line_horizontal?(ante1, ante2)
  ante1[0] == ante2[0]
end

def same_line_vertical?(ante1, ante2)
  ante1[1] == ante2[1]
end

def get_antinodes_horizontal(ante1, ante2)
  smaller_ante = ante1[1] < ante2[1] ? ante1 : ante2
  bigger_ante = ante1[1] < ante2[1] ? ante2 : ante1

  distance = bigger_ante[1] - smaller_ante[1]

  antinodes_one = [ante1[0], smaller_ante[1] - distance]
  antinodes_two = [ante1[0], bigger_ante[1] + distance]

  [antinodes_one, antinodes_two]
end

def get_antinodes_vertical(ante1, ante2)
  smaller_ante = ante1[0] < ante2[0] ? ante1 : ante2
  bigger_ante = ante1[0] < ante2[0] ? ante2 : ante1

  distance = bigger_ante[0] - smaller_ante[0]

  antinodes_one = [smaller_ante[0] - distance, ante1[1]]
  antinodes_two = [bigger_ante[0] + distance, ante1[1]]

  [antinodes_one, antinodes_two]
end

def get_antinodes_diagonal(ante1, ante2)
  smaller_ante = ante1[0] < ante2[0] ? ante1 : ante2
  bigger_ante = ante1[0] < ante2[0] ? ante2 : ante1

  distance_x = bigger_ante[0] - smaller_ante[0]
  distance_y = bigger_ante[1] - smaller_ante[1]

  [
    [smaller_ante[0] - distance_x, smaller_ante[1] - distance_y],
    [bigger_ante[0] + distance_x, bigger_ante[1] + distance_y]
  ]
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
