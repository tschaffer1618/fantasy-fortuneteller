require 'rails_helper'

describe 'As a visitor' do
  scenario 'I cannot view the admin dashboard' do
    visit admin_users_path

    expect(current_path).to eq root_path
    expect(page).to have_content("You are not authorized to see this content.")
  end
end
