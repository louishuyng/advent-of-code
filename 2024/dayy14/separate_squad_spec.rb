require 'rspec/autorun'
require './separate_squad'

describe '#separate_squad' do
  it 'should return squads separated by middle verticle line and middle horizontal line' do
    robots = [[5, 3], [4, 5], [0, 9], [5, 4], [6, 1], [3, 1], [0, 6], [3, 2], [2, 0], [0, 6], [5, 4], [6, 6]]
    titles = [7, 11]

    expect(separate_squad(robots, titles)).to eq(
      [
        [[2, 0]],
        [[0, 9], [0, 6], [0, 6]],
        [[5, 3], [5, 4], [6, 1], [5, 4]],
        [[6, 6]]
      ]
    )
  end
end
