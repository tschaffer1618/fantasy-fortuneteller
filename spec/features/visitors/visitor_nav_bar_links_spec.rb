require 'rails_helper'

describe "A visitor" do
  scenario "can click the nav bar link to the root page" do
    visit root_path

    find("img[alt='Crystal Ball']").click

    expect(current_path).to eq root_path
  end

  scenario "can click the link to sign in with google" do

  end

  scenario "can click the link to see a teams index page" do

  end

  scenario "can click the link to see league stats" do

  end

  scenario "can click the link to the player search page" do

  end
end
