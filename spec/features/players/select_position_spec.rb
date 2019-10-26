require 'rails_helper'

describe 'Players' do
  before(:each) do
    @user = create(:user, user_name: "Jason Bourne")
    @tom_brady = Player.create!(display_name: 'Tom Brady', position: 'QB')
    @ryan_fitzpatrick = Player.create!(display_name: 'Ryan Fitzpatrick', position: 'QB')
    @christian = Player.create!(display_name: 'Christian McCaffrey', position: 'RB')
    @deandre = Player.create!(display_name: 'DeAndre Hopkins', position: 'WR')
    @ravens = Player.create!(display_name: 'Balitmore Ravens', position: 'DEF')
    @greg = Player.create!(display_name: 'Greg Zuerlein', position: 'K')
    @george = Player.create!(display_name: 'George Kittle', position: 'TE')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  it ' user can see players for specific position' do
    visit players_path

    click_on 'Position'
    within '#position-dropdown' do
      expect(page).to have_content("Quarterback")
      expect(page).to have_content("Running Back")
      expect(page).to have_content("Tight End")
      expect(page).to have_content("Wide Receiver")
      expect(page).to have_content("Defense")
      expect(page).to have_content("Tight End")
      click_on 'Quarterback'
    end

    expect(page).to have_content(@tom_brady.display_name)
    expect(page).to have_content(@ryan_fitzpatrick.display_name)
    expect(page).to_not have_content(@christian.display_name)
    expect(page).to_not have_content(@george.display_name)

    click_on 'Position'
    within '#position-dropdown' do
      click_on 'All'
    end
    expect(page).to have_content(@tom_brady.display_name)
    expect(page).to have_content(@ryan_fitzpatrick.display_name)
    expect(page).to have_content(@christian.display_name)
    expect(page).to have_content(@george.display_name)
  end
end
