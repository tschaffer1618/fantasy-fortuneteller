require 'rails_helper'

describe Player, type: :model do
  describe "relationships" do
    it {should have_many :team_players}
    it {should have_many(:teams).through(:team_players)}
  end

  describe 'class methods' do
    it 'search' do
      expect(Player.search()).to eq(Player.all)
      expect(Player.search("")).to eq(Player.all)
      expect(Player.search('Name')).to eq([])
      @player_1 = create(:player, display_name: 'name')
      @player_2 = create(:player)
      expect(Player.search('Name').first).to eq(@player_1)
    end

    it 'search_position' do
      @player_1 = create(:player, display_name: 'name')
      @player_2 = create(:player, position: "DEF")
      expect(Player.search_position("all")).to eq(Player.all)
      expect(Player.search_position("DEF").first).to eq(@player_2)
    end

    it 'current_team_player' do
      @team = create(:team)
      @player_1 = create(:player, display_name: 'name')
      @team_player = @player_1.team_players.create(team_id: @team.id)
      expect(@player_1.current_team_player(@team)).to eq(@team_player)
    end
  end

  describe 'instance methods' do
    describe '#current_status' do
      context 'player is healthy and does not have a bye week' do
        it 'returns "✔"' do
          player = create(:player,
            bye_week: 4,
            projection_week: 9,
            current_projection: 12.34,
            injury_status: nil
          )

          expect(player.current_status).to eq('✔')
        end
      end

      context 'player is healthy and has a bye week' do
        it 'returns "Bye"' do
          player = create(:player,
            bye_week: 9,
            projection_week: 9,
            current_projection: 0.0,
            injury_status: nil
          )

          expect(player.current_status).to eq('Bye')
        end
      end

      context 'player is injured' do
        it 'returns their injury status' do
          player = create(:player,
            bye_week: 7,
            projection_week: 9,
            current_projection: 0.0,
            injury_status: '(Knee) Out for week 9'
          )

          expect(player.current_status).to eq('(Knee) Out for week 9')
        end
      end
    end

    it '#defense_photo_url' do
      player = create(:player,
            team: 'MIA'
          )

      defense = create(:player,
            team: 'MIA',
            position: 'DEF',
            photo_url: 'test.jpg'
          )

      expect(player.defense_photo_url).to eq defense.photo_url
    end
  end
end
