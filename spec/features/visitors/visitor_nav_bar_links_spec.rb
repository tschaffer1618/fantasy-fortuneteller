require 'rails_helper'

describe "A visitor" do
  scenario "can click the nav bar link to the root page" do
    visit root_path

    find("img[alt='Crystal Ball']").click

    expect(current_path).to eq root_path
  end

  scenario "can click the link to see a teams index page" do
    visit root_path

    click_link("My Teams")

    expect(current_path).to eq root_path
    expect(page).to have_content("Please sign in to see this content.")
  end

  scenario "can click the link to see league stats" do
    visit root_path

    click_link("League Stats")

    expect(current_path).to eq root_path
    expect(page).to have_content("Please sign in to see this content.")
  end

  scenario "can click the link to the player search page" do
    visit root_path

    click_link("Player Search")

    expect(current_path).to eq root_path
    expect(page).to have_content("Please sign in to see this content.")
  end
end
