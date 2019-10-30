require 'rails_helper'

describe 'As a new user' do
  context 'I have not verified my email yet' do
    before :each do
      @user = create(:user, verified: false)
      allow_any_instance_of(ApplicationController)
        .to receive(:current_user).and_return(@user)
    end

    scenario 'I can access my profile, but it tells me to check my email' do
      visit profile_path

      expect(current_path).to eq(profile_path)
      expect(page).to have_content(@user.email)
      expect(page).to_not have_link('Edit Profile')
      expect(page).to_not have_css('.teams')
    end

    scenario 'I cannot visit "My Teams"' do
      visit user_teams_path

      expect(current_path).to eq(profile_path)
      expect(page).to have_content('Please verify your account to see this content.')
    end

    scenario 'I cannot visit player index or show pages' do
      visit players_path

      expect(current_path).to eq(profile_path)
      expect(page).to have_content('Please verify your account to see this content.')

      player = create(:player)

      visit player_path(player)

      expect(current_path).to eq(profile_path)
      expect(page).to have_content('Please verify your account to see this content.')
    end
  end
end
