require 'rails_helper'

describe 'Visitor can register' do
  it 'they can authorize with google oauth2' do
    stub_omniauth
    visit root_path
    expect(page).to have_link("Sign in with Google")
    click_link "Sign in with Google"
    expect(page).to have_content("Alec Wells")
    expect(page).to have_link("Logout")
  end
end
