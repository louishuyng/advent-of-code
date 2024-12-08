require 'rspec/autorun'
require './get_antinodes'

describe '#get_antinodes_by_antennas' do
  boundary = [10, 10]

  describe 'when antinodes are inside boundary' do
    it 'returns all antinodes inside boundary left diagonal' do
      node_one = [3, 4]
      node_two = [5, 5]

      expect(
        get_antinodes_by_antennas(
          node_one,
          node_two,
          boundary
        )
      ).to eq(
        [[1, 3], [7, 6]]
      )
    end

    it 'returns all antinodes inside boundary right diagonal' do
      node_one = [2, 4]
      node_two = [3, 3]

      expect(
        get_antinodes_by_antennas(
          node_one,
          node_two,
          boundary
        )
      ).to eq(
        [[1, 5], [4, 2]]
      )
    end

    it 'returns all antinodes inside boundary horizontally' do
      node_one = [3, 3]
      node_two = [3, 6]

      expect(
        get_antinodes_by_antennas(
          node_one,
          node_two,
          boundary
        )
      ).to eq(
        [[3, 0], [3, 9]]
      )
    end

    it 'returns all antinodes inside boundary vertically' do
      node_one = [3, 3]
      node_two = [6, 3]

      expect(
        get_antinodes_by_antennas(
          node_one,
          node_two,
          boundary
        )
      ).to eq(
        [[0, 3], [9, 3]]
      )
    end
  end

  describe 'when antinodes are outside boundary' do
    it 'returns only antinodes inside boundary' do
      node_one = [3, 4]
      node_two = [3, 7]

      expect(
        get_antinodes_by_antennas(
          node_one,
          node_two,
          boundary
        )
      ).to eq([[3, 1], nil])
    end
  end
end
