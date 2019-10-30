require 'rails_helper'

describe "A logged in user" do
  before(:each) do
    @user = create(:user, user_name: "fft")
    @team = @user.teams.create(name: "What The Flacco")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  scenario "can click the nav bar link to the root page" do
    visit root_path

    within '.navbar' do
      find("img[alt='Crystal Ball']").click
    end
    
    expect(current_path).to eq root_path
  end

  scenario "can click the link to see their teams index page" do
    visit root_path

    click_link("My Teams")

    expect(current_path).to eq user_teams_path
  end

  scenario "can click the link to see a specific team show page" do
    visit root_path

    click_link("What The Flacco")

    expect(current_path).to eq user_team_path(@team)
  end

  scenario "can click the link to see league stats" do
    visit root_path

    click_link("League Stats")

    expect(current_path).to eq '/leaguestats'
  end

  scenario "can click the link to the player search page" do
    visit root_path

    click_link("Player Search")

    expect(current_path).to eq players_path
  end

  scenario "can click the link to their profile" do
    visit root_path

    click_link("My Profile")

    expect(current_path).to eq profile_path
  end
end
