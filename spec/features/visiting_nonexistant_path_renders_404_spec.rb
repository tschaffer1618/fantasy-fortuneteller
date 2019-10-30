require 'rails_helper'

describe 'As a user' do
  context 'I type in any route that is not an actual route' do
    scenario 'I see a 404 error message' do
      user = create(:user)
      allow_any_instance_of(ApplicationController)
        .to receive(:current_user).and_return(user)

      visit '/this_is_not_a_path'

      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end
