require 'rspec/autorun'
require './moving_bot'

describe '#moving_bot' do
  it 'should return new bot position' do
    bot_position = [4, 2]
    vector = [-3, 2]
    titles = [7, 11]

    expect(moving_bot(bot_position, vector, titles, 1)).to eq(
      [1, 4]
    )

    expect(moving_bot(bot_position, vector, titles, 2)).to eq(
      [5, 6]
    )

    expect(moving_bot(bot_position, vector, titles, 3)).to eq(
      [2, 8]
    )

    expect(moving_bot(bot_position, vector, titles, 4)).to eq(
      [6, 10]
    )

    expect(moving_bot(bot_position, vector, titles, 5)).to eq(
      [3, 1]
    )
  end
end
