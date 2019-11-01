require 'rails_helper'

context 'As a logged in user' do
  context 'I visit the league stats page' do
    before :each do
      @user = create(:user)
      allow_any_instance_of(ApplicationController)
        .to receive(:current_user)
        .and_return(@user)

      @qb1 = create(:player, position: 'QB', current_projection: 5)
      @qb2 = create(:player, position: 'QB', current_projection: 10)
      @qb3 = create(:player, position: 'QB', current_projection: 15)
      @qb4 = create(:player, position: 'QB', current_projection: 20)
      @qb5 = create(:player, position: 'QB', current_projection: 25)
      @qb6 = create(:player, position: 'QB', current_projection: 30)

      @rb1 = create(:player, position: 'RB', current_projection: 5)
      @rb2 = create(:player, position: 'RB', current_projection: 10)
      @rb3 = create(:player, position: 'RB', current_projection: 15)
      @rb4 = create(:player, position: 'RB', current_projection: 20)
      @rb5 = create(:player, position: 'RB', current_projection: 25)
      @rb6 = create(:player, position: 'RB', current_projection: 30)

      @wr1 = create(:player, position: 'WR', current_projection: 5)
      @wr2 = create(:player, position: 'WR', current_projection: 10)
      @wr3 = create(:player, position: 'WR', current_projection: 15)
      @wr4 = create(:player, position: 'WR', current_projection: 20)
      @wr5 = create(:player, position: 'WR', current_projection: 25)
      @wr6 = create(:player, position: 'WR', current_projection: 30)

      @te1 = create(:player, position: 'TE', current_projection: 5)
      @te2 = create(:player, position: 'TE', current_projection: 10)
      @te3 = create(:player, position: 'TE', current_projection: 15)
      @te4 = create(:player, position: 'TE', current_projection: 20)
      @te5 = create(:player, position: 'TE', current_projection: 25)
      @te6 = create(:player, position: 'TE', current_projection: 30)

      @k1 = create(:player, position: 'K', current_projection: 5)
      @k2 = create(:player, position: 'K', current_projection: 10)
      @k3 = create(:player, position: 'K', current_projection: 15)
      @k4 = create(:player, position: 'K', current_projection: 20)
      @k5 = create(:player, position: 'K', current_projection: 25)
      @k6 = create(:player, position: 'K', current_projection: 30)

      @def1 = create(:player, position: 'DEF', current_projection: 5)
      @def2 = create(:player, position: 'DEF', current_projection: 10)
      @def3 = create(:player, position: 'DEF', current_projection: 15)
      @def4 = create(:player, position: 'DEF', current_projection: 20)
      @def5 = create(:player, position: 'DEF', current_projection: 25)
      @def6 = create(:player, position: 'DEF', current_projection: 30)
    end

    scenario 'I see a section for top 5 projected performances for each position' do
      visit leaguestats_path

      expect(current_path).to eq(leaguestats_path)

      within ".top-5-quarterbacks" do
        expect(page).to have_content(@qb6.display_name)
        expect(page).to have_content("(#{@qb6.team})")
        expect(page).to have_content(@qb6.current_projection)
        @qb6.display_name.should appear_before(@qb5.display_name)
        @qb5.display_name.should appear_before(@qb4.display_name)
        @qb4.display_name.should appear_before(@qb3.display_name)
        @qb3.display_name.should appear_before(@qb2.display_name)
        expect(page).to_not have_content(@qb1.display_name)
      end

      within ".top-5-running-backs" do
        expect(page).to have_content(@rb6.display_name)
        expect(page).to have_content("(#{@rb6.team})")
        expect(page).to have_content(@rb6.current_projection)
        @rb6.display_name.should appear_before(@rb5.display_name)
        @rb5.display_name.should appear_before(@rb4.display_name)
        @rb4.display_name.should appear_before(@rb3.display_name)
        @rb3.display_name.should appear_before(@rb2.display_name)
        expect(page).to_not have_content(@rb1.display_name)
      end

      within ".top-5-wide-receivers" do
        expect(page).to have_content(@wr6.display_name)
        expect(page).to have_content("(#{@wr6.team})")
        expect(page).to have_content(@wr6.current_projection)
        @wr6.display_name.should appear_before(@wr5.display_name)
        @wr5.display_name.should appear_before(@wr4.display_name)
        @wr4.display_name.should appear_before(@wr3.display_name)
        @wr3.display_name.should appear_before(@wr2.display_name)
        expect(page).to_not have_content(@wr1.display_name)
      end

      within ".top-5-tight-ends" do
        expect(page).to have_content(@te6.display_name)
        expect(page).to have_content("(#{@te6.team})")
        expect(page).to have_content(@te6.current_projection)
        @te6.display_name.should appear_before(@te5.display_name)
        @te5.display_name.should appear_before(@te4.display_name)
        @te4.display_name.should appear_before(@te3.display_name)
        @te3.display_name.should appear_before(@te2.display_name)
        expect(page).to_not have_content(@te1.display_name)
      end

      within ".top-5-kickers" do
        expect(page).to have_content(@k6.display_name)
        expect(page).to have_content("(#{@k6.team})")
        expect(page).to have_content(@k6.current_projection)
        @k6.display_name.should appear_before(@k5.display_name)
        @k5.display_name.should appear_before(@k4.display_name)
        @k4.display_name.should appear_before(@k3.display_name)
        @k3.display_name.should appear_before(@k2.display_name)
        expect(page).to_not have_content(@k1.display_name)
      end

      within ".top-5-defenses" do
        expect(page).to have_content(@def6.display_name)
        expect(page).to have_content("(#{@def6.team})")
        expect(page).to have_content(@def6.current_projection)
        @def6.display_name.should appear_before(@def5.display_name)
        @def5.display_name.should appear_before(@def4.display_name)
        @def4.display_name.should appear_before(@def3.display_name)
        @def3.display_name.should appear_before(@def2.display_name)
        expect(page).to_not have_content(@def1.display_name)
      end
    end
  end
end
