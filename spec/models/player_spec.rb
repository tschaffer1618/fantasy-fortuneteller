require 'rails_helper'

describe Player, type: :model do
  describe "relationships" do
    it {should have_many :team_players}
    it {should have_many(:teams).through(:team_players)}
  end
end
