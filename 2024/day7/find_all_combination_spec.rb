require 'rspec/autorun'
require './find_all_combination'

describe '#find_all_combination' do
  it 'should able to find all combination' do
    expect(find_all_combination(3)).to eq(
      [
        %i[add add add],
        %i[add add multiply],
        %i[add multiply add],
        %i[add multiply multiply],
        %i[multiply add add],
        %i[multiply add multiply],
        %i[multiply multiply add],
        %i[multiply multiply multiply]
      ]
    )
  end
end
