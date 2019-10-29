class TeamPlayer < ApplicationRecord
  belongs_to :team
  belongs_to :player

  def self.does_not_exist?(team_player_params)
    TeamPlayer.where(team_player_params).empty?
  end
end
