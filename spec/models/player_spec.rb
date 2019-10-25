require 'rails_helper'

describe Player, type: :model do
  xdescribe "relationships" do
    it {should have_many :team_players}
  end
end
