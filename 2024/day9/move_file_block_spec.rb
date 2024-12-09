require 'rspec/autorun'
require './move_file_block'

describe '#move_file_block_from_end_to_free_left' do
  it 'moves file block from end to free left' do
    spaces = '00...111...2...333.44.5555.6666.777.888899'.split('')

    expect(
      move_file_block_from_end_to_free_left(spaces)
    ).to eq(
        '009..111...2...333.44.5555.6666.777.88889.'.split('')
    )
  end

  it 'moves file block from end to free left' do
    spaces = '009..111...2...333.44.5555.6666.777.88889.'.split('')

    expect(
      move_file_block_from_end_to_free_left(spaces)
    ).to eq(
      '0099.111...2...333.44.5555.6666.777.8888..'.split('')
    )
  end

  it 'moves file block from end to free left' do
    spaces = '0099.111...2...333.44.5555.6666.777.8888..'.split('')

    expect(
      move_file_block_from_end_to_free_left(spaces)
    ).to eq(
      '00998111...2...333.44.5555.6666.777.888...'.split('')
    )
  end
end
