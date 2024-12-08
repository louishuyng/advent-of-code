require 'rspec/autorun'
require './get_antinodes_v2'

describe '#get_antinodes_by_antennas' do
  boundary = [10, 10]

  describe 'when antinodes are inside boundary' do
    it 'returns all antinodes inside boundary horizontal' do
      node_one = [0, 0]
      node_two = [0, 2]

      expect(
        get_antinodes_by_antennas(
          node_one,
          node_two,
          boundary
        )
      ).to eq(
        [[0, 4], [0, 6], [0, 8]]
      )
    end

    it 'returns all antinodes inside boundary vertical' do
      node_one = [0, 0]
      node_two = [2, 0]

      expect(
        get_antinodes_by_antennas(
          node_one,
          node_two,
          boundary
        )
      ).to eq(
        [[4, 0], [6, 0], [8, 0]]
      )
    end

    it 'returns all antinodes inside boundary left diagonal' do
      node_one = [0, 0]
      node_two = [2, 1]

      expect(
        get_antinodes_by_antennas(
          node_one,
          node_two,
          boundary
        )
      ).to eq(
        [[4, 2], [6, 3], [8, 4]]
      )
    end

    it 'returns all antinodes inside boundary right diagonal' do
      node_one = [0, 0]
      node_two = [1, 3]

      expect(
        get_antinodes_by_antennas(
          node_one,
          node_two,
          boundary
        )
      ).to eq(
        [[2, 6], [3, 9]]
      )
    end
  end
end
