class AddBenchedToTeamPlayers < ActiveRecord::Migration[5.2]
  def change
    add_column :team_players, :benched, :boolean, default: true
  end
end
