require './input_reader'
require './get_antinodes'

def program
  antennas, boundary = read_input
  puts "Antennas: #{antennas}"
  puts "Boundary: #{boundary}"

  antinodes = []

  antennas.each do |key, value|
    puts "Antena: #{key}"

    find_all_antinodes_of_antena(value, boundary).each do |antinode|
      antinodes << antinode
    end
  end

  count = count_all_uniques_antinodes(antinodes)

  puts "Antinodes No: #{count}"
end

def find_all_antinodes_of_antena(antenas, boundary)
  antinodes = []

  for i in 0..antenas.length - 1
    for j in i + 1..antenas.length - 1
      antena1 = antenas[i]
      antena2 = antenas[j]

      antinode_one, antinode_two = get_antinodes_by_antennas(antena1, antena2, boundary)

      antinodes << antinode_one if antinode_one
      antinodes << antinode_two if antinode_two
    end
  end

  antinodes
end

def count_all_uniques_antinodes(antinodes)
  count = 0
  tracked = {}

  antinodes.each do |antinode|
    tracked[antinode[0]] = [] unless tracked[antinode[0]]

    unless tracked[antinode[0]].include?(antinode[1])
      tracked[antinode[0]] << antinode[1]
      count += 1
    end
  end

  count
end

program
