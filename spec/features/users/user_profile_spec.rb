require 'rails_helper'

describe 'user profile' do
  it ' user can view profile' do
    user_1 = create(:user, user_name: 'fft', verified: true)
    user_2 = create(:user, user_name: 'not fft', verified: true)
    team_1 = create(:team, name: 'Not team 2', user_id: user_1.id)
    team_2 = create(:team, name: 'Not team 1', user_id: user_2.id)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

    visit profile_path

    within ".user-info" do
      expect(page).to have_content("Name: #{user_1.first_name} #{user_1.last_name}")
      expect(page).to have_content("Username: #{user_1.user_name}")
      expect(page).to have_content("Email: #{user_1.email}")
    end
  end

  it ' user can edit profile' do
    user_1 = create(:user, user_name: 'fft', verified: true)
    team_1 = create(:team, name: 'Not team 2', user_id: user_1.id)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

    visit profile_path

    click_link 'Edit Profile'

    expect(current_path).to eq(edit_user_path(user_1))

    fill_in "Email", with: "new_email@email.com"
    fill_in "User name", with: "Gus"
    click_button("Update User")

    expect(current_path).to eq(profile_path)

    within ".user-info" do
      expect(page).to have_content("Name: #{user_1.first_name} #{user_1.last_name}")
      expect(page).to have_content("Username: Gus")
      expect(page).to have_content("Email: new_email@email.com")
    end
  end
end
