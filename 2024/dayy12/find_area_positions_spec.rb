require 'rspec/autorun'
require './find_area_positions'

A = 'A'
X = 'X'
B = 'B'
C = 'C'
D = 'D'
E = 'E'

describe '#find_area_positions' do
  describe 'test 1' do
    it 'returns correct result' do
      garden = [
        [A, A, A, A],
        [B, B, C, D],
        [B, B, C, C],
        [E, E, E, C]
      ]

      expect(find_area_positions(garden)).to eq(
        [
          { name: 'A', positions: [[0, 0], [0, 1], [0, 2], [0, 3]] },
          { name: 'B', positions: [[1, 0], [1, 1], [2, 1], [2, 0]] },
          { name: 'C', positions: [[1, 2], [2, 2], [2, 3], [3, 3]] },
          { name: 'D', positions: [[1, 3]] },
          { name: 'E', positions: [[3, 0], [3, 1], [3, 2]] }
        ]
      )
    end
  end

  describe 'test 2' do
    it 'returns correct result' do
      garden = [
        %w[0 0 0 0 0],
        ['0', X, '0', X, '0'],
        %w[0 0 0 0 0],
        ['0', X, '0', X, '0'],
        %w[0 0 0 0 0]
      ]

      expect(find_area_positions(garden)).to eq(
        [
          {
            name: '0',
            positions: [
              [0, 0], [0, 1], [0, 2], [0, 3], [0, 4],
              [1, 4], [2, 4], [3, 4], [4, 4], [4, 3],
              [4, 2], [4, 1], [4, 0], [3, 0], [2, 0],
              [2, 1], [2, 2], [2, 3], [3, 2], [1, 2],
              [1, 0]
            ]
          },
          { name: X, positions: [[1, 1]] },
          { name: X, positions: [[1, 3]] },
          { name: X, positions: [[3, 1]] },
          { name: X, positions: [[3, 3]] }
        ]
      )
    end
  end
end
