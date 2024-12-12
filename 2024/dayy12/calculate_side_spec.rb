require 'rspec/autorun'
require './calculate_side'

describe '#calculate_side' do
  describe 'test 1' do
    it 'returns correct result' do
      points = [[0, 0], [0, 1], [0, 2], [0, 3]]

      expect(calculate_side(points)).to eq(4)
    end
  end

  describe 'test 2' do
    it 'returns correct result' do
      points = [[1, 2], [2, 2], [2, 3], [3, 3]]

      expect(calculate_side(points)).to eq(8)
    end
  end

  describe 'test 3' do
    it 'returns correct result' do
      points = [[1, 0], [1, 1], [2, 0], [2, 1]]

      expect(calculate_side(points)).to eq(4)
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

      expect(calculate_side(points)).to eq(10)
    end
  end

  describe 'test 5' do
    it 'returns correct result' do
      points = [
        [0, 8], [0, 9],
        [1, 9],
        [2, 8], [2, 9],
        [3, 7], [3, 9], [3, 8],
        [4, 8], [2, 7]
      ]

      expect(calculate_side(points)).to eq(12)
    end
  end

  describe 'test 6' do
    it 'returns correct result' do
      points = [
        [2, 0], [2, 1],
        [3, 0], [3, 1],
        [4, 0], [4, 1], [4, 2], [4, 3],
        [5, 0], [5, 3], [5, 1],
        [6, 1], [6, 0]
      ]

      expect(calculate_side(points)).to eq(10)
    end
  end
end
