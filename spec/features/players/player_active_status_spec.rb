require 'rails_helper'

describe 'A user visits the player search page or team show page' do
  context 'The player is healthy and does not have a bye week' do
    scenario 'It shows their status is active with "✔"' do
      user = create(:user, verified: true)
      team = create(:team, user: user)
      player = create(:player, bye_week: 3, projection_week: 4, injury_status: nil)
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

  context 'The player is healthy, but has a bye week' do
    scenario 'It shows their status is "Bye"' do
      user = create(:user, verified: true)
      team = create(:team, user: user)
      player = create(:player, bye_week: 4, projection_week: 4, injury_status: nil)
      create(:team_player, team: team, player: player)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit players_path

      within "#player-#{player.id}" do
        within '.status' do
          expect(page).to have_content('Bye')
        end
      end

      visit user_team_path(team)

      within "#player-section-#{player.id}" do
        within '.status' do
          expect(page).to have_content('Bye')
        end
      end
    end
  end

  context 'The player injured' do
    scenario 'It shows their injury status' do
      user = create(:user, verified: true)
      team = create(:team, user: user)
      player = create(:player, bye_week: 4, projection_week: 4, injury_status: '(Knee) Out')
      create(:team_player, team: team, player: player)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit players_path

      within "#player-#{player.id}" do
        within '.status' do
          expect(page).to have_content('(Knee) Out')
        end
      end

      visit user_team_path(team)

      within "#player-section-#{player.id}" do
        within '.status' do
          expect(page).to have_content('(Knee) Out')
        end
      end
    end
  end
end
