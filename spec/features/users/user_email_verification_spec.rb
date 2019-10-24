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

    expect(page).to have_content("Thank you!  Your account has been activated.")
    expect(user.verified).to eq(true)

    username = 'fft'
    expect(page).to have_conent("Please choose a username")
    fill_in 'user[username]', with: ""
    click_on 'Submit'

    expect(page).to have_conent("User name can't be blank")

    fill_in 'user[username]', with: username
    click_on 'Submit'

    expect(current_path).to eq root_path
  end
end
