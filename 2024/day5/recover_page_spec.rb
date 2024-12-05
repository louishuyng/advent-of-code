require 'rspec/autorun'
require './recover_page'

describe '#recover_page' do
  it 'should able to recover the page' do
    print = {
      47 => { before: [97, 75], after: [53, 13, 61, 29] },
      53 => { before: [47, 75, 61, 97], after: [29, 13] },
      97 => { before: [], after: [13, 61, 47, 29, 53, 75] },
      13 => { before: [97, 61, 29, 47, 75, 53], after: [] },
      61 => { before: [97, 47, 75], after: [13, 53, 29] },
      75 => { before: [97], after: [29, 53, 47, 61, 13] },
      29 => { before: [75, 97, 53, 61, 47], after: [13] }
    }

    expect(recover_page([75, 97, 47, 61, 53], print)).to eq([97, 75, 47, 61, 53])
    expect(recover_page([61, 13, 29], print)).to eq([61, 29, 13])
    expect(recover_page([97, 13, 75, 29, 47], print)).to eq([97, 75, 47, 29, 13])
  end
end
