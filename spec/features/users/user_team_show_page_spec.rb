require 'rails_helper'

describe "A logged in user on a team show page" do
  before(:each) do
    @user = create(:user, user_name: "Jason Bourne")
    @team_1 = @user.teams.create(name: "What The Flacco")
    @player_1 = create(:player, display_name: "Frank Gore", photo_url: 'http://static.nfl.com/static/content/public/static/img/fantasy/transparent/512x512/BRA371156.png')
    @player_2 = create(:player, display_name: "Aaron Jones", photo_url: 'http://static.nfl.com/static/content/public/static/img/fantasy/transparent/512x512/BRA371156.png')
    @player_3 = create(:player, display_name: "Tom Brady", photo_url: 'http://static.nfl.com/static/content/public/static/img/fantasy/transparent/512x512/BRA371156.png')
    @team_player_1 = @team_1.team_players.create(player: @player_1)
    @team_player_2 = @team_1.team_players.create(player: @player_2)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  scenario "can see a list of the players on the team" do
    visit user_team_path(@team_1)

    expect(page).to have_content("Frank Gore")
    expect(page).to have_content("Aaron Jones")
    expect(page).to_not have_content("Tom Brady")
  end

  scenario "can click a player name to go to the player show page" do
    visit user_team_path(@team_1)

    click_link("Frank Gore")

    expect(current_path).to eq player_path(@player_1)
  end

  scenario "can remove a player from the team" do
    visit user_team_path(@team_1)

    within("#player-section-#{@player_1.id}") do
      click_button("Remove")
    end

    expect(current_path).to eq user_team_path(@team_1)
    expect(page).to have_content("Player deleted!")
    expect(page).to_not have_content("Frank Gore")
    expect(page).to have_content(@player_2.display_name)
  end

  scenario "can add a player to the team" do
    visit user_team_path(@team_1)

    fill_in "myPlayerInput", with: "Tom Brady"
    click_button("Add Player")

    expect(current_path).to eq user_team_path(@team_1)
    expect(page).to have_content("Tom Brady has been added to your team!")
    expect(page).to have_content("Tom Brady")
  end

  scenario "cannot add the same player to the team multiple times" do
    visit user_team_path(@team_1)

    fill_in "myPlayerInput", with: "Tom Brady"
    click_button("Add Player")

    fill_in "myPlayerInput", with: "Tom Brady"
    click_button("Add Player")

    expect(current_path).to eq user_team_path(@team_1)
    expect(page).to have_content("Tom Brady is already on that team.")

    expect(all('.player').count).to eq(3)
  end

  scenario "cannot add a non-existent player to the team" do
    visit user_team_path(@team_1)

    fill_in "myPlayerInput", with: "Not a Name of an NFL Player"
    click_button("Add Player")

    expect(current_path).to eq user_team_path(@team_1)
    expect(page).to have_content("No player found matching that name.")
  end
end
