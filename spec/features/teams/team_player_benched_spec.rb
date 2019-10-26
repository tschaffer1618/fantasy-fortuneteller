require 'rails_helper'

describe "A logged in user on a team show page" do
  before(:each) do
    @user = create(:user, user_name: "Jason Bourne")
    @team_1 = @user.teams.create(name: "What The Flacco")
    @team_2 = @user.teams.create(name: "spooooky")
    @player_1 = create(:player, display_name: "Frank Gore", current_projection: 4, photo_url: 'http://static.nfl.com/static/content/public/static/img/fantasy/transparent/512x512/BRA371156.png')
    @player_2 = create(:player, display_name: "Aaron Jones", current_projection: 2, photo_url: 'http://static.nfl.com/static/content/public/static/img/fantasy/transparent/512x512/BRA371156.png')
    @player_3 = create(:player, display_name: "Tom Brady", photo_url: 'http://static.nfl.com/static/content/public/static/img/fantasy/transparent/512x512/BRA371156.png')
    @team_player_1 = @team_1.team_players.create(player: @player_1)
    @team_player_2 = @team_1.team_players.create(player: @player_2)
    @team_player_3 = @team_2.team_players.create(player: @player_1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  scenario "can change player status to benched or unbenched" do
    visit user_team_path(@team_1)

    within "#player-section-#{@player_1.id}" do
      within ".benched" do
        expect(page).to have_content("Put me in")
        click_on "Put me in!"
      end
    end

    expect(current_path).to eq(user_team_path(@team_1))
    # expect(@team_player_1.benched).to eq(false)

    within "#player-section-#{@player_1.id}" do
      within ".benched" do
        expect(page).to have_content("Take me out")
        click_on "Take me out"
      end
    end

    expect(current_path).to eq(user_team_path(@team_1))
    # expect(@team_player_1.benched).to eq(true)
  end

  it "shows total_projected_score" do
    visit user_team_path(@team_1)

    expect(page).to have_content("Total Projected Score: 0.0")

    within "#player-section-#{@player_1.id}" dox
      within ".benched" do
        click_on "Put me in!"
      end
    end

    expect(page).to have_content("Total Projected Score: 4.0")

    within "#player-section-#{@player_2.id}" do
      within ".benched" do
        click_on "Put me in!"
      end
    end

    expect(page).to have_content("Total Projected Score: 6.0")
  end
end
