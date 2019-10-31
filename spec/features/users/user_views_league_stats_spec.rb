require 'rails_helper'

context 'As a logged in user' do
  context 'I visit the league stats page' do
    before :each do
      @user = create(:user)
      allow_any_instance_of(ApplicationController)
        .to receive(:current_user)
        .and_return(@user)
    end

    scenario 'I see a section for top 5 projected performances for each position' do
      visit leaguestats_path

      expect(current_path).to eq(leaguestats_path)

      within '#current-top-5' do
        expect(page).to have_css('#top-5-quarterback')
        expect(page).to have_css('#top-5-running-backs')
        expect(page).to have_css('#top-5-wide-receivers')
        expect(page).to have_css('#top-5-tight-ends')
        expect(page).to have_css('#top-5-kickers')
        expect(page).to have_css('#top-5-defense')
      end
    end
  end
end
