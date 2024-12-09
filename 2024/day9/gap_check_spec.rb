require 'rspec/autorun'
require './gap_check'

describe '#has_gap_between_file_blocks' do
  it 'returns true when there is no gap between file blocks' do
    spaces = '00998111...2...333.44.5555.6666.777.888...'.split('')

    expect(has_gap_between_file_blocks(spaces)).to be_truthy
  end

  it 'returns false when there is a gap between file blocks' do
    spaces = '0099811188827773336446555566..............'.split('')

    expect(has_gap_between_file_blocks(spaces)).to be_falsey
  end
end
