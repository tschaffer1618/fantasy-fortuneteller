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
  end
end
