require 'rspec/autorun'
require './finding_path'

describe '#cheapest_tokens_to_win_prize' do
  describe 'test 1' do
    it 'should return smallest path to prize' do
      button_a = [94, 34]
      button_b = [22, 67]
      prize_location = [8400, 5400]

      expect(cheapest_tokens_to_win_prize(button_a, button_b, prize_location)).to eq(280)
    end
  end

  describe 'test 2' do
    it 'should return smallest path to prize' do
      button_a = [17, 86]
      button_b = [84, 37]
      prize_location = [7870, 6450]

      expect(cheapest_tokens_to_win_prize(button_a, button_b, prize_location)).to eq(200)
    end
  end

  describe 'test 3' do
    it 'should return 0 if no path to prize' do
      button_a = [26, 66]
      button_b = [67, 21]
      prize_location = [12_748, 12_176]

      expect(cheapest_tokens_to_win_prize(button_a, button_b, prize_location)).to eq(0)
    end
  end
end
