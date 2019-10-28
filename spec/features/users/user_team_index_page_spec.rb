require 'rails_helper'

describe "A logged in user" do
  before(:each) do
    @user = create(:user, user_name: "Jason Bourne")
    @team_1 = @user.teams.create(name: "What The Flacco")
    @team_2 = @user.teams.create(name: "The Brady Bunch")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  scenario "can see a list of their teams with names that link to the team show page" do
    visit user_teams_path

    expect(page).to have_link("What The Flacco")
    expect(page).to have_link("The Brady Bunch")

    within "#team-section-#{@team_1.id}" do
      click_link("What The Flacco")
    end

    expect(current_path).to eq user_team_path(@team_1)
  end

  scenario "cannot see another user's teams" do
    user_2 = create(:user, user_name: "Gandalf")
    team_3 = user_2.teams.create(name: "The Hobbits")

    # @user is still current_user
    visit user_team_path(team_3)

    expect(current_path).to eq user_teams_path
    expect(page).to have_content("Forbidden")
  end

  scenario "cannot edit another user's teams" do
    user_2 = create(:user, user_name: "Gandalf")
    team_3 = user_2.teams.create(name: "The Hobbits")

    # @user is still current_user
    visit edit_user_team_path(team_3)

    expect(current_path).to eq user_teams_path
    expect(page).to have_content("Forbidden")
  end

  scenario "can add a new team" do
    visit user_teams_path

    click_link("New Team")

    expect(current_path).to eq new_user_team_path

    fill_in "Name", with: "Test Team"
    click_button("Create Team")

    expect(current_path).to eq user_teams_path
    expect(page).to have_content("New team created!")


    expect(page).to have_link("Test Team")
  end

  scenario "cannot add a team without a name" do
    visit user_teams_path

    click_link("New Team")

    expect(current_path).to eq new_user_team_path

    fill_in "Name", with: ""
    click_button("Create Team")

    expect(current_path).to eq new_user_team_path
    expect(page).to have_content("Name can't be blank")
  end

  scenario "can edit a team name" do
    visit user_teams_path

    within("#team-section-#{@team_1.id}") do
      click_link("Change Name")
    end

    expect(current_path).to eq edit_user_team_path(@team_1)
    fill_in "Name", with: "Mahomes Is Where The Heart Is"

    click_button("Update Team")
    @team_1.reload

    expect(current_path).to eq user_teams_path
    expect(page).to have_content("Team name updated!")

    visit user_teams_path

    expect(page).to have_link("Mahomes Is Where The Heart Is")
    expect(page).to_not have_link("What The Flacco")
  end

  scenario "cannot edit a team name to be blank" do
    visit user_teams_path

    within("#team-section-#{@team_1.id}") do
      click_link("Change Name")
    end

    expect(current_path).to eq edit_user_team_path(@team_1)
    fill_in "Name", with: ""

    click_button("Update Team")

    expect(current_path).to eq edit_user_team_path(@team_1)
    expect(page).to have_content("Name can't be blank")
  end

  scenario "can delete a team" do
    visit user_teams_path

    within("#team-section-#{@team_1.id}") do
      click_link("Delete Team")
    end
    @user.reload

    expect(current_path).to eq user_teams_path
    expect(page).to have_content("Team deleted!")

    visit user_teams_path

    expect(page).to_not have_link("What The Flacco")
  end
end
