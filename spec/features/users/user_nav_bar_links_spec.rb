require 'rails_helper'

describe "A logged in user" do
  before(:each) do
    @user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  scenario "can click the nav bar link to the root page" do
    visit root_path
    save_and_open_page
  end

  scenario "can click the log out link" do

  end

  scenario "can click the link to see their teams index page" do

  end

  scenario "can click the link to see a specific team show page" do

  end

  scenario "can click the link to see league stats" do

  end

  scenario "can click the link to the player search page" do

  end

  scenario "can click the link to their profile" do

  end
end
