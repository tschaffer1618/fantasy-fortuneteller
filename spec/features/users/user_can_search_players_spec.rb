require 'rails_helper'

describe 'user profile' do
  it ' user can search players' do
    user_1 = create(:user, user_name: 'fft', verified: true)
    user_2 = create(:user, user_name: 'not fft', verified: true)
    team_1 = create(:team, name: 'Not team 2', user_id: user_1.id)
    team_2 = create(:team, name: 'Not team 1', user_id: user_2.id)
    tom_brady = Player.create!(display_name: 'Tom Brady')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

    visit user_teams_path(user_1)

    # click_link 'Add Player'
    #
    # expect(current_path).to eq('/players/search')
    within ".search-player" do
      fill_in 'Search', with: "Tom Brady"
    end

    click_on 'Search'

    expect(current_path).to eq("/players/#{tom_brady.id}")
  end
end
