require 'rspec/autorun'
require './calculate_area'

describe '#calculate_area' do
  describe 'test 1' do
    it 'returns correct result' do
      points = [[0, 0], [0, 1], [0, 2], [0, 3]]

      expect(calculate_area(points)).to eq(4)
    end
  end

  describe 'test 2' do
    it 'returns correct result' do
      points = [[1, 2], [2, 2], [2, 3], [3, 3]]

      expect(calculate_area(points)).to eq(4)
    end
  end

  describe 'test 3' do
    it 'returns correct result' do
      points = [[1, 0], [1, 1], [2, 0], [2, 1]]

      expect(calculate_area(points)).to eq(4)
    end
  end

  describe 'test 4' do
    it 'returns correct result' do
      points = [[0, 0], [0, 1], [0, 2]]

      expect(calculate_area(points)).to eq(3)
    end
  end
end
