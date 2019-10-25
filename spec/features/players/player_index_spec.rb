require 'rails_helper'

describe 'Players' do
  it ' user can view player index page' do
    user_1 = create(:user, user_name: 'fft', verified: true)
    team_1 = create(:team, name: 'Not team 2', user_id: user_1.id)
    tom_brady = Player.create!(display_name: 'Tom Brady')
    d_a = Player.create!(display_name: 'Derek Anderson')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

    visit players_path

    expect(page).to have_content(tom_brady.display_name)
    expect(page).to have_content(tom_brady.position)
    expect(page).to have_content(tom_brady.jersey)
    expect(page).to have_content(tom_brady.team)

    expect(page).to have_content(d_a.display_name)
    expect(page).to have_content(d_a.position)
    expect(page).to have_content(d_a.jersey)
    expect(page).to have_content(d_a.team)
  end
end
