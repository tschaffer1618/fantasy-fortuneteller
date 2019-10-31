require 'rails_helper'

describe Team, type: :model do
  describe "relationships" do
    it {should belong_to :user}
    it {should have_many(:players).through(:team_players)}
  end

  describe "validations" do
    it {should validate_presence_of :name}
  end

  describe "dependencies" do
    it "destroys team_players when a team is destroyed" do
      user = create(:user, user_name: "Test")
      player = create(:player)
      team = user.teams.create!(name: "Test team")
      team_player = team.team_players.create!(player: player)

      expect { team.destroy }.to change { TeamPlayer.count }.by(-1)
    end
  end
end
