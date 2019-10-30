require 'rails_helper'

describe "An admin user" do
  before(:each) do
    @admin = create(:user, user_name: "Admin", role: 1)
    @user = create(:user, user_name: "Jason Bourne")
    @user_2 = create(:user, user_name: "Jennifer Garner")
    @team_1 = @user.teams.create(name: "What The Flacco")
    @player_1 = create(:player, display_name: "Frank Gore", photo_url: 'http://static.nfl.com/static/content/public/static/img/fantasy/transparent/512x512/BRA371156.png')
    @player_2 = create(:player, display_name: "Aaron Jones", photo_url: 'http://static.nfl.com/static/content/public/static/img/fantasy/transparent/512x512/BRA371156.png')
    @player_3 = create(:player, display_name: "Tom Brady", photo_url: 'http://static.nfl.com/static/content/public/static/img/fantasy/transparent/512x512/BRA371156.png')
    @team_player_1 = @team_1.team_players.create(player: @player_1)
    @team_player_2 = @team_1.team_players.create(player: @player_2)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
  end

  scenario "can visit the admin dashboard from the nav bar" do
    visit root_path

    click_link("Dashboard")

    expect(current_path).to eq admin_users_path
  end
end
