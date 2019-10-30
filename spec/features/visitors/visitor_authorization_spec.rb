require 'rails_helper'

describe 'As a visitor' do
  scenario 'I cannot view the admin dashboard' do
    visit admin_users_path

    expect(page).to have_content("The page you were looking for doesn't exist.")
  end
end
