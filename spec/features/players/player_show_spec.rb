require 'rails_helper'

describe 'Players' do
  before(:each) do
    @user_1 = create(:user, user_name: 'fft', verified: true)
    @team_1 = create(:team, name: 'Not team 2', user_id: @user_1.id)
    @tom_brady = Player.create!(
              display_name: 'Tom Brady',
              position: 'QB',
              jersey: '12',
              team: 'PAT',
              current_projection: 14.6,
              projection_week: 15,
              college: 'Michigan',
              experience: "20th season",
              birth_date: "October 31, 1976",
              height: "6-4",
              weight: 220,
              ffn_id: 13
            )
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)

    @json_projections = File.open('./fixtures/projection_data.json')
    stub_request(:get, "https://ff-nerd-service.herokuapp.com/all_player_projections/13?key=#{ENV['MY_FF_API_KEY']}")
      .to_return(status: 200, body: @json_projections)
  end

  it ' user can view player show page' do
    visit player_path(@tom_brady)

    expect(page).to have_content(@tom_brady.display_name)
    expect(page).to have_content(@tom_brady.position)
    expect(page).to have_content(@tom_brady.jersey)
    expect(page).to have_content(@tom_brady.team)
    expect(page).to have_content(@tom_brady.current_projection)
    expect(page).to have_content(@tom_brady.projection_week)
    expect(page).to have_content(@tom_brady.college)
    expect(page).to have_content(@tom_brady.birth_date)
    expect(page).to have_content(@tom_brady.height)
    expect(page).to have_content(@tom_brady.weight)
    expect(page).to have_content(@tom_brady.experience)
  end

  it ' user can add a player to a team' do
    visit player_path(@tom_brady)

    click_on("Add to team")

    within('.dropdown-menu') do
      click_on("Not team 2")
    end

    expect(current_path).to eq player_path(@tom_brady)
    expect(page).to have_content("Tom Brady has been added to your team!")

    visit user_team_path(@team_1)

    expect(page).to have_content("Tom Brady")
  end
end
