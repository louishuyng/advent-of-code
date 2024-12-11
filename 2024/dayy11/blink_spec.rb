require 'rspec/autorun'
require './blink'

describe '#blink_stones' do
  describe 'test case 1' do
    it 'returns correct result' do
      stones = [125, 17]

      expect(blink_stones(stones)).to eq([253_000, 1, 7])
    end
  end

  describe 'test case 2' do
    it 'returns correct result' do
      stones = [253_000, 1, 7]

      expect(blink_stones(stones)).to eq([253, 0, 2024, 14_168])
    end
  end

  describe 'test case 3' do
    it 'returns correct result' do
      stones = [253, 0, 2024, 14_168]

      expect(blink_stones(stones)).to eq([512_072, 1, 20, 24, 28_676_032])
    end
  end

  describe 'test case 4' do
    it 'returns correct result' do
      stones = [0, 1, 10, 99, 999]
      expect(blink_stones(stones)).to eq([1, 2024, 1, 0, 9, 9, 2_021_976])
    end
  end
end
