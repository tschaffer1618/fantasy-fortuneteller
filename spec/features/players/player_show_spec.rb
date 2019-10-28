require 'rails_helper'

describe 'Players' do
  it ' user can view player show page' do
    user_1 = create(:user, user_name: 'fft', verified: true)
    team_1 = create(:team, name: 'Not team 2', user_id: user_1.id)
    tom_brady = Player.create!(display_name: 'Tom Brady')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

    visit player_path(tom_brady)

    expect(page).to have_content(tom_brady.display_name)
    expect(page).to have_content(tom_brady.position)
    expect(page).to have_content(tom_brady.jersey)
    expect(page).to have_content(tom_brady.team)
  end
end
