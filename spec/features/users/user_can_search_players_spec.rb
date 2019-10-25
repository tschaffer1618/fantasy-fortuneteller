require 'rails_helper'

describe 'user profile' do
  it ' user can view profile' do
    user_1 = create(:user, user_name: 'fft', verified: true)
    user_2 = create(:user, user_name: 'not fft', verified: true)
    team_1 = create(:team, name: 'Not team 2', user_id: user_1.id)
    team_2 = create(:team, name: 'Not team 1', user_id: user_2.id)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

    visit user_teams_path(user_1)

    click_link 'Add Player'

    expect(current_path).to eq('/players/search')
  end
end
