require 'rspec/autorun'
require './input_reader'
require './find_trail_head_score'

describe '#find_trail_head_score' do
  it 'find correct trail head score for test1' do
    map, positions = read_input('test_files/test1')

    expect(find_trail_head_score(map, positions)).to eq(2)
  end

  it 'find correct trail head score for test2' do
    map, positions = read_input('test_files/test2')

    expect(find_trail_head_score(map, positions)).to eq(4)
  end

  it 'find correct trail head score for test3' do
    map, positions = read_input('test_files/test3')

    expect(find_trail_head_score(map, positions)).to eq(3)
  end
end
