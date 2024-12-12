require 'rspec/autorun'
require './calculate_perimeter'

describe '#calculate_perimeter' do
  describe 'test 1' do
    it 'returns correct result' do
      points = [[0, 0], [0, 1], [0, 2], [0, 3]]

      expect(calculate_perimeter(points)).to eq(10)
    end
  end

  describe 'test 2' do
    it 'returns correct result' do
      points = [[1, 2], [2, 2], [2, 3], [3, 3]]

      expect(calculate_perimeter(points)).to eq(10)
    end
  end

  describe 'test 3' do
    it 'returns correct result' do
      points = [[1, 0], [1, 1], [2, 0], [2, 1]]

      expect(calculate_perimeter(points)).to eq(8)
    end
  end

  describe 'test 4' do
    it 'returns correct result' do
      points = [
        [0, 0], [0, 1], [0, 2], [0, 3],
        [1, 0], [1, 1], [1, 2], [1, 3],
        [2, 2], [2, 3], [2, 4],
        [3, 2]
      ]

      expect(calculate_perimeter(points)).to eq(18)
    end
  end
end
