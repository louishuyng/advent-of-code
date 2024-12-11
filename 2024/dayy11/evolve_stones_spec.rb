require 'rspec/autorun'
require './evolve_stones'

describe '#evolve_stones' do
  it 'returns correct result' do
    stones = [125, 17]

    expect(evolve_stones(stones, 25)).to eq(55_312)
  end
end
