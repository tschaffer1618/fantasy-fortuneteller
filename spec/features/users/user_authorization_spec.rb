require 'rails_helper'

describe 'As a logged in user' do
  before(:each) do
    @user = create(:user, user_name: "Jason Bourne")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  scenario 'I cannot view the admin dashboard' do
    visit admin_users_path

    expect(page).to have_content("The page you were looking for doesn't exist.")
  end
end
