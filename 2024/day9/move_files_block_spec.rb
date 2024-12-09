require 'rspec/autorun'
require './move_files_block'

describe '#move_files_block_to_free_left' do
  it 'moves file block from end to free left for space id 9' do
    spaces = '00...111...2...333.44.5555.6666.777.888899'.split('')

    expect(
      move_files_block_to_free_left(spaces, '9')
    ).to eq(
      '0099.111...2...333.44.5555.6666.777.8888..'.split('')
    )
  end

  it 'returns nil if there is no free space for space id 8' do
    spaces = '0099.111...2...333.44.5555.6666.777.8888..'.split('')

    expect(
      move_files_block_to_free_left(spaces, '8')
    ).to be_nil
  end

  it 'moves file block from end to free left for space id 7' do
    spaces = '0099.111...2...333.44.5555.6666.777.8888..'.split('')

    expect(
      move_files_block_to_free_left(spaces, '7')
    ).to eq(
      '0099.1117772...333.44.5555.6666.....8888..'.split('')
    )
  end

  it 'returns nil if there are no space from left to current block id' do
    spaces = '00992111777.44.333....5555.6666.....8888..'.split('')

    expect(
      move_files_block_to_free_left(spaces, '1')
    ).to be_nil
  end
end
