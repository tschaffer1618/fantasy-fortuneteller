require 'rails_helper'

describe Player, type: :model do
  describe "relationships" do
    it {should have_many :team_players}
    it {should have_many(:teams).through(:team_players)}
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

  describe 'class_methods' do
    it 'current_top_5' do
      qb1 = create(:player, position: 'QB', current_projection: 5)
      qb2 = create(:player, position: 'QB', current_projection: 10)
      qb3 = create(:player, position: 'QB', current_projection: 15)
      qb4 = create(:player, position: 'QB', current_projection: 20)
      qb5 = create(:player, position: 'QB', current_projection: 25)
      qb6 = create(:player, position: 'QB', current_projection: 30)

      expected = [qb6, qb5, qb4, qb3, qb2]

      expect(Player.current_top_5('QB')).to eq(expected)
    end
  end
end
