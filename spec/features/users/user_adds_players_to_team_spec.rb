require 'rails_helper'

describe "User can add player to team" do
  before(:each) do
    @user = create(:user, user_name: "Jason Bourne")
    @team_1 = @user.teams.create(name: "What The Flacco")
    @team_2 = @user.teams.create(name: "The Brady Bunch")
    @ryan_fitzpatrick = Player.create!(display_name: 'Ryan Fitzpatrick')
    @joe_flacco = Player.create!(display_name: 'Joe Flacco')
    @chad_henne = Player.create!(display_name: 'Chad Henne')
    @derek_anderson = Player.create!(display_name: 'Derek Anderson')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  scenario "can visit team index and select player to add to team" do
    visit players_path

    within "#player-#{@ryan_fitzpatrick.id}" do
      expect(page).to have_content("Add to team")
      click_on("Add to team")
      click_on "#{@team_1.name}"
    end

    expect(current_path).to eq(players_path)
    expect(page).to have_content("#{@ryan_fitzpatrick.display_name} has been added to your team.")

    visit user_team_path(@team_1)

    expect(page).to have_content(@ryan_fitzpatrick.display_name)
    expect(page).to have_content(@ryan_fitzpatrick.position)
  end

  it "can't add the same player twice" do
    visit players_path

    within "#player-#{@ryan_fitzpatrick.id}" do
      expect(page).to have_content("Add to team")
      click_on("Add to team")
      click_on "#{@team_1.name}"
    end

    within "#player-#{@ryan_fitzpatrick.id}" do
      expect(page).to have_content("Add to team")
      click_on("Add to team")
      click_on "#{@team_1.name}"
    end

    expect(page).to have_content("Sorry, #{@ryan_fitzpatrick.display_name} is already on your team.")
  end
end
