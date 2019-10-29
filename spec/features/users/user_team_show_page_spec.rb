require 'rails_helper'

describe "A logged in user" do
  before(:each) do
    @user = create(:user, user_name: "Jason Bourne")
    @team_1 = @user.teams.create(name: "What The Flacco")
    @player_1 = create(:player, display_name: "Frank Gore")
    @player_2 = create(:player, display_name: "Aaron Jones")
    @player_3 = create(:player, display_name: "Tom Brady")
    @team_player_1 = @team_1.team_players.create(player: @player_1)
    @team_player_2 = @team_1.team_players.create(player: @player_2)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  scenario "can see a list of the players on a team in the team show page" do
    visit user_team_path(@team_1)

    expect(page).to have_content("Frank Gore")
    expect(page).to have_content("Aaron Jones")
    expect(page).to_not have_content("Tom Brady")
  end

  scenario "can remove a player from the team" do
    visit user_team_path(@team_1)

    within("#player-section-#{@player_1.id}") do
      click_link("Remove Player")
    end

    expect(current_path).to eq user_team_path(@team_1)
    expect(page).to have_content("Player deleted!")
    expect(page).to_not have_content("Frank Gore")
  end

  scenario "can add a player to the team" do
    visit user_team_path(@team_1)

    fill_in "myInput", with: "Tom Brady"
    click_button("Add Player")

    expect(current_path).to eq user_team_path(@team_1)
    expect(page).to have_content("Player added!")
    expect(page).to have_content("Tom Brady")
  end

  scenario "cannot add the same player to the team multiple times" do
    visit user_team_path(@team_1)

    fill_in "myInput", with: "Tom Brady"
    click_button("Add Player")

    fill_in "myInput", with: "Tom Brady"
    click_button("Add Player")

    expect(current_path).to eq user_team_path(@team_1)
    expect(page).to have_content("Player already on team.")

    expect(all('.player').count).to eq(3)
  end
end
