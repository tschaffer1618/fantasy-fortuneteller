require 'rails_helper'

describe 'Players' do
  before(:each) do
    @user = create(:user, user_name: "Jason Bourne")
    @tom_brady = Player.create!(display_name: 'Tom Brady')
    @drew_brees = Player.create!(display_name: 'Drew Brees')
    @ryan_fitzpatrick = Player.create!(display_name: 'Ryan Fitzpatrick')
    @joe_flacco = Player.create!(display_name: 'Joe Flacco')
    @chad_henne = Player.create!(display_name: 'Chad Henne')
    @derek_anderson = Player.create!(display_name: 'Derek Anderson')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  it ' user can search player by exact name' do
    visit players_path

    within '.search-player' do
      fill_in "search", with: 'Tom Brady'
      click_on 'Search'
    end

    expect(current_path).to eq(players_path)
    expect(page).to have_content(@tom_brady.display_name)
    expect(page).to_not have_content(@drew_brees.display_name)
  end

  it ' user can search player by part of name' do
    visit players_path

    within '.search-player' do
      fill_in "search", with: 'br'
      click_on 'Search'
    end

    expect(page).to have_content(@tom_brady.display_name)
    expect(page).to have_content(@drew_brees.display_name)
    expect(page).to_not have_content(@chad_henne.display_name)
  end

  it ' alerts user if no matches found' do
    visit players_path

    within '.search-player' do
      fill_in "search", with: 'br'
      click_on 'Search'
    end

    expect(page).to have_content("Player not found")

  end
end
