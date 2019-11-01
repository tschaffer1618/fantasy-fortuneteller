require 'rails_helper'

describe Team, type: :model do
  describe "relationships" do
    it {should belong_to :user}
    it {should have_many(:players).through(:team_players)}
  end

  describe "validations" do
    it {should validate_presence_of :name}
  end

  describe 'instance methods' do
    it 'active_team_players' do
      @team = create(:team)
      @team_player = create(:team_player, team_id: @team.id, benched: false)
      expect(@team.active_team_players.first).to eq(@team_player)
    end
    it 'total_projected_score' do
      @team = create(:team)
      @player = create(:player, current_projection: 4.0)
      @team_player = create(:team_player, team_id: @team.id, player_id: @player.id, benched: false)
      expect(@team.total_projected_score).to eq(4.0)
    end
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
