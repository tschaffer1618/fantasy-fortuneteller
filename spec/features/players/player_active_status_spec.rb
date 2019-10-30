require 'rails_helper'

describe 'A user visits the player search page or team show page' do
  context 'The player is healthy and does not have a bye week' do
    scenario 'It shows their status is active' do
      user = create(:user, verified: true)
      team = create(:team, user: user)
      player = create(:player)
      create(:team_player, team: team, player: player)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit players_path

      within "#player-#{player.id}" do
        within '.status' do
          expect(page).to have_content('✔')
        end
      end

      visit user_team_path(team)

      within "#player-section-#{player.id}" do
        within '.status' do
          expect(page).to have_content('✔')
        end
      end
    end
  end
end
