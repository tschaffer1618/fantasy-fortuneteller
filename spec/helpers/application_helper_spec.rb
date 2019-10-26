require 'rails_helper'

describe ApplicationHelper, type: :helper do
  describe "methods" do

    it 'player_positions' do
      expected = [
        ['All', 'all'],
        ['Quarterback', 'QB'],
        ['Wide Receiver', 'WR'],
        ['Running Back', 'RB'],
        ['Kicker', 'K'],
        ['Tight End', 'TE'],
        ['Defense', 'DEF'],
      ]
      expect(expected).to eq(player_positions)
    end
  end
end
