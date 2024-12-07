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

    expect(find_all_combination(2, %i[add multiply combine])).to eq(
      [
        %i[add add],
        %i[add multiply],
        %i[add combine],
        %i[multiply add],
        %i[multiply multiply],
        %i[multiply combine],
        %i[combine add],
        %i[combine multiply],
        %i[combine combine]
      ]
    )
  end
end
