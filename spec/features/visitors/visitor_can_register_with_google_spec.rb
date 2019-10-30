require 'rails_helper'

describe 'Visitor can register' do
  scenario 'they can authorize with google oauth2' do
    stub_omniauth
    visit root_path

    expect(page).to have_link("Sign in with Google")

    click_link "Sign in with Google"

    expect(page).to have_content("This account has not been verified. Please check your email at alec@gmail.com")
    expect(page).to have_link("Logout")

    click_link 'Logout'

    expect(page).to_not have_content("This account has not been verified. Please check your email.")
    expect(page).to_not have_link("Logout")

    expect(page).to have_link('Sign in with Google')

  end
end
