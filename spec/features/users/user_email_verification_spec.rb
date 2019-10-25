require 'rails_helper'

describe 'email verification' do
  it ' user can verify account through email' do
    stub_omniauth
    visit root_path
    click_link "Sign in with Google"

    user = User.last
    expect(user.verified).to eq(false)
    expect(page).to have_content('This account has not been verified. Please check your email.')

    visit "verification/#{user.id}"
    user = User.last

    expect(page).to have_content("Verified ✔")
    expect(user.verified).to eq(true)

    expect(current_path).to eq profile_path
  end
end
